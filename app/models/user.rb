class User < ApplicationRecord
    # Configuración de Devise y OmniAuth
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           :omniauthable, omniauth_providers: [:google_oauth2, :apple]
  
    # Enum de roles globales
    enum :global_role, { standard: 0, super_admin: 1, developer: 2, c_level: 3 }, default: :standard
  
    # Relaciones según la base de datos
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
  
    def dark?
      theme == "dark"
    end
  
    # Autenticación y creación de usuario desde OmniAuth (Google & Apple)
    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
  
        if auth.info.first_name.present? || auth.info.last_name.present?
          user.first_name = auth.info.first_name || "Usuario"
          user.last_name = auth.info.last_name || "Drivver"
        else
          name_parts = (auth.info.name || "Usuario Drivver").split(" ")
          user.first_name = name_parts.first
          user.last_name = name_parts.drop(1).join(" ").presence || "Drivver"
        end
  
        # Valores predeterminados para evitar null violations
        user.id_type ||= "CC"
        user.id_number ||= "PENDING_#{SecureRandom.hex(4)}"
        user.phone_country_code ||= "+57"
        user.phone_number ||= "PENDING_#{SecureRandom.hex(4)}"
        user.city ||= "Bogotá"
        user.active = true
      end
    end
  end