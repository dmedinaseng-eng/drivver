# db/migrate/20260916000000_create_initial_schema.rb
class CreateInitialSchema < ActiveRecord::Migration[7.1]
  def change
    # ==========================================
    # 1. USERS & FAMILIES
    # ==========================================
    create_table :users do |t|
      # Datos Personales Drivver
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :id_number, null: false
      t.string :id_type, null: false
      t.boolean :active, null: false, default: false
      t.string :city, null: false
      t.string :phone_country_code, null: false
      t.string :phone_number, null: false
      t.string :theme, null: false, default: 'light'
      
      # Pundit / Global Auth Enum (0: standard, 1: super_admin, 2: developer, 3: c_level)
      t.integer :global_role, null: false, default: 0

      # Devise Core
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      # Devise Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      # Devise Rememberable
      t.datetime :remember_created_at

      # OmniAuth (Google & Apple Sign-In)
      t.string :provider
      t.string :uid

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, [:provider, :uid], unique: true
    add_index :users, :phone_number, unique: true
    add_index :users, [:id_number, :id_type], unique: true, name: 'idx_users_id_number_type'
    add_index :users, [:id_number, :phone_number, :email], name: 'idx_users_search'

    create_table :families do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :family_members do |t|
      t.references :family, null: false, foreign_key: { on_delete: :cascade }
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.string :status, null: false, default: 'Pending'
      t.string :role
      t.timestamps
    end

    # ==========================================
    # 2. PLANS & SUBSCRIPTIONS
    # ==========================================
    create_table :plans do |t|
      t.string :name, null: false
      t.string :target_type, null: false
      t.decimal :price_cents, null: false
      t.jsonb :features_config
      t.timestamps
    end

    create_table :subscriptions do |t|
      t.references :subscribable, polymorphic: true, null: false
      t.references :plan, null: false, foreign_key: true
      t.string :status, null: false
      t.date :expires_at
      t.timestamps
    end

    # ==========================================
    # 3. ORGANIZATIONS & CRM
    # ==========================================
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :tax_id, null: false # (NIT/RUT)
      t.string :org_type, null: false
      t.string :phone_number, null: false
      t.string :phone_country_code, null: false
      t.string :email
      t.timestamps
    end

    create_table :organization_roles do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :cascade }
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.string :role_name, null: false
      t.jsonb :permissions, null: false
      t.timestamps
    end

    create_table :crm_customers do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :cascade }
      t.string :lead_type, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone_number, null: false
      t.string :phone_country_code, null: false
      t.string :email
      t.text :notes
      t.references :converted_user, foreign_key: { to_table: :users, on_delete: :nullify }
      t.timestamps
    end

    # ==========================================
    # 4. VEHICLES & OPERATIONS
    # ==========================================
    create_table :vehicles do |t|
      t.references :user, null: false, foreign_key: { on_delete: :restrict }
      t.references :family, foreign_key: { on_delete: :nullify }
      t.string :plate, null: false
      t.string :color, null: false
      t.string :chasis_id, null: false
      t.string :motor_id, null: false
      t.string :vehicle_type, null: false
      t.string :brand, null: false
      t.string :model, null: false
      t.string :year, null: false
      t.timestamps
    end

    create_table :deals do |t|
      t.references :vehicle, null: false, foreign_key: { on_delete: :restrict }
      t.references :organization, foreign_key: { on_delete: :nullify }
      t.references :agent_seller, foreign_key: { to_table: :users, on_delete: :nullify }
      t.references :client, null: false, foreign_key: { to_table: :users, on_delete: :restrict }
      t.references :agent_buyer, foreign_key: { to_table: :users, on_delete: :nullify }
      t.string :deal_type, null: false
      t.string :status, null: false
      t.timestamps
    end

    create_table :offers do |t|
      t.references :deal, null: false, foreign_key: { on_delete: :cascade }
      t.references :offeror_user, null: false, foreign_key: { to_table: :users, on_delete: :restrict }
      t.references :organization, foreign_key: { on_delete: :nullify }
      t.decimal :amount_cents, null: false
      t.string :status, null: false
      t.timestamps
    end

    create_table :events do |t|
      t.references :vehicle, null: false, foreign_key: { on_delete: :cascade }
      t.references :organization, foreign_key: { on_delete: :nullify } 
      t.references :user, null: false, foreign_key: { on_delete: :restrict }
      t.string :event_type, null: false
      t.string :status, null: false
      t.boolean :custody_flag, null: false, default: false
      t.decimal :price_cents, null: false
      t.timestamps
    end

    create_table :event_requirements do |t|
      t.references :event, null: false, foreign_key: { on_delete: :cascade }
      t.text :description, null: false
      t.decimal :cost_cents
      t.boolean :approved_by_user, null: false, default: false
      t.datetime :approved_at
      t.timestamps
    end

    # ==========================================
    # 5. FEATURES, NOTES & CMS
    # ==========================================
    create_table :features do |t|
      t.string :name, null: false
      t.string :category
      t.string :target_model, null: false
      t.text :description
      t.timestamps
    end

    create_table :entity_features do |t|
      t.references :feature, null: false, foreign_key: { on_delete: :cascade }
      t.references :featurable, polymorphic: true, null: false
      t.timestamps
    end

    create_table :notes do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :notable, polymorphic: true, null: false
      t.text :content, null: false
      t.string :privacy_level, null: false, default: 'private'
      t.references :organization, foreign_key: { on_delete: :nullify }
      t.timestamps
    end

    create_table :documents do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :cascade }
      t.string :title, null: false
      t.text :file_url, null: false
      t.boolean :is_public, null: false, default: false
      t.boolean :read_only_image, null: false, default: false
      t.timestamps
    end

    create_table :blog_posts do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :cascade }
      t.references :author, null: false, foreign_key: { to_table: :users, on_delete: :restrict }
      t.string :title, null: false
      t.string :slug, null: false
      t.text :content, null: false
      t.string :meta_title
      t.text :meta_description
      t.jsonb :schema_json
      t.string :status, null: false, default: 'draft'
      t.timestamps
    end

    add_index :blog_posts, :slug, unique: true

    create_table :blog_reviews do |t|
      t.references :blog_post, null: false, foreign_key: { on_delete: :cascade }
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.integer :rating, null: false
      t.text :comment
      t.timestamps
    end

    # ==========================================
    # ÍNDICES DE BÚSQUEDA Y RENDIMIENTO
    # ==========================================

    # Families
    add_index :families, :name

    # Organizations (Búsquedas muy frecuentes en el SaaS)
    add_index :organizations, :tax_id
    add_index :organizations, :name
    add_index :organizations, :org_type

    # Vehicles (Búsquedas exactas por placa o identificadores son críticas)
    add_index :vehicles, :plate
    add_index :vehicles, :chasis_id
    add_index :vehicles, :motor_id
    add_index :vehicles, [:brand, :model] # Índice compuesto para filtros por marca y modelo
    add_index :vehicles, :vehicle_type

    # Deals (Filtros en el tablero/CRM del dealership)
    add_index :deals, :status
    add_index :deals, :deal_type

    # Events (Filtros en los talleres)
    add_index :events, :status
    add_index :events, :event_type

    # Features (Para cargar rápido las características disponibles por modelo)
    add_index :features, :name
    add_index :features, :target_model
    add_index :features, :category

    # Notes
    add_index :notes, :privacy_level

    # Documents
    add_index :documents, :is_public

    # Blog Posts (Para SEO y listados públicos)
    # Nota: :slug ya tiene índice único en tu migración anterior
    add_index :blog_posts, :status

    # Blog Reviews
    add_index :blog_reviews, :rating
  end
end