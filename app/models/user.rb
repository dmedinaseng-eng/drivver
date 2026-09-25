class User < ApplicationRecord
  # Configuración de Devise + OmniAuth
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]

  # Enum de roles globales
  enum :global_role, { standard: 0, super_admin: 1, developer: 2, c_level: 3 }, default: :standard

  enum :theme, { light: 0, dark: 1 }, default: :light

  # Relación para Passkeys (WebAuthn / FIDO2)
  has_many :webauthn_credentials, dependent: :destroy

  has_many :subscriptions, as: :subscribable, dependent: :destroy

  # Relaciones del ecosistema Drivver
  has_many :organization_roles, dependent: :destroy
  has_many :organizations, through: :organization_roles
  has_many :vehicles, dependent: :restrict_with_error
  has_many :family_members, dependent: :destroy
  has_many :families, through: :family_members
  has_many :events, dependent: :restrict_with_error
  has_many :notes, dependent: :destroy
  has_many :blog_reviews, dependent: :destroy

  # Validaciones
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  # Métodos de presentación
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

  # Crear o encontrar usuario desde Google OAuth / One Tap
  def self.from_omniauth(auth)
    user = find_by(provider: auth.provider, uid: auth.uid) || find_by(email: auth.info.email)

    if user
      user.update(provider: auth.provider, uid: auth.uid) if user.uid != auth.uid.to_s
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
end
