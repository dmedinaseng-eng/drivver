class User < ApplicationRecord
  before_validation :set_default_context, on: :create

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]

  enum :global_role, { standard: 0, super_admin: 1, developer: 2, c_level: 3 }, default: :standard

  enum :theme, { light: "light", dark: "dark" }, default: :light


  has_many :webauthn_credentials, dependent: :destroy
  has_many :subscriptions, as: :subscribable, dependent: :destroy
  has_many :organization_roles, dependent: :destroy
  has_many :organizations, through: :organization_roles
  has_many :vehicles, dependent: :restrict_with_error
  has_many :family_members, dependent: :destroy
  has_many :families, through: :family_members
  has_many :events, dependent: :restrict_with_error
  has_many :notes, dependent: :destroy
  has_many :blog_reviews, dependent: :destroy
  has_many :deals, class_name: "Deal", foreign_key: "client_id", dependent: :destroy
  has_many :sales_deals, class_name: "Deal", foreign_key: "agent_seller_id"
  has_many :purchase_deals, class_name: "Deal", foreign_key: "agent_buyer_id"

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def internal_team?
    super_admin? || developer? || c_level?
  end

  def active_subscription
    subscriptions.where(status: "active").where("expires_at > ?", Date.today).first
  end

  def current_plan
    active_subscription&.plan || Plan.find_by(name: "basic")
  end

  def active_organization
    return nil if operating_in_personal_context? || operating_in_admin_context?

    organizations.find_by(id: current_context)
  end

  def active_context_name
    current_context.presence || "personal"
  end

  def operating_in_personal_context?
    (current_context.presence || "personal") == "personal"
  end

  def operating_in_admin_context?
    current_context == "admin" && internal_team?
  end

  def operating_in_org_context?
    !operating_in_personal_context? && !operating_in_admin_context?
  end

  def operating_in_dealership?
    active_organization&.org_type == "dealership"
  end

  def operating_in_workshop?
    active_organization&.org_type == "workshop"
  end

  def operating_in_detailer?
    active_organization&.org_type == "detailer_shop"
  end

  def operating_in_agency?
    active_organization&.org_type == "marketing_agency"
  end

  def active_backoffice_type
    return "admin" if operating_in_admin_context?
    return "personal" if operating_in_personal_context?

    active_organization&.org_type || "personal"
  end

  def self.from_omniauth(auth)
    user = find_by(provider: auth.provider, uid: auth.uid) || find_by("lower(email) = ?", auth.info.email.downcase)
    if user
      if user.uid != auth.uid.to_s
        user.update_columns(provider: auth.provider, uid: auth.uid)
      end
      return user
    end

    create! do |record|
      record.provider = auth.provider
      record.uid = auth.uid
      record.email = auth.info.email
      record.password = Devise.friendly_token[0, 20]

      if auth.info.first_name.present? || auth.info.last_name.present?
        record.first_name = auth.info.first_name.presence || "Usuario"
        record.last_name = auth.info.last_name.presence || "Drivver"
      else
        name_parts = (auth.info.name || "Usuario Drivver").split(" ")
        record.first_name = name_parts.first
        record.last_name = name_parts.drop(1).join(" ").presence || "Drivver"
      end

      record.id_type ||= "CC"
      record.id_number ||= "PENDING_#{SecureRandom.hex(4)}"
      record.phone_country_code ||= "CO"
      record.phone_number ||= "PENDING_#{SecureRandom.hex(4)}"
      record.city ||= "Bogotá"
      record.active = true
    end
  end

  def self.from_google_payload(payload)
    raise ArgumentError, "email missing" if payload["email"].blank?
    raise ArgumentError, "email not verified" if payload["email_verified"] == false

    auth = OmniAuth::AuthHash.new(
      provider: "google_oauth2",
      uid: payload["sub"],
      info: {
        email: payload["email"],
        name: payload["name"],
        first_name: payload["given_name"],
        last_name: payload["family_name"]
      }
    )
    from_omniauth(auth)
  end

  private

  def set_default_context
    self.current_context = "personal" if current_context.blank?
  end
end
