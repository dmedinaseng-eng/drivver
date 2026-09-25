class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    enable_extension "pgcrypto" unless extension_enabled?("pgcrypto")

    create_table :users, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :id_number
      t.string :id_type
      t.boolean :active
      t.string :city
      t.string :phone_country_code
      t.string :phone_number
      t.string :theme
      t.integer :global_role
      t.string :provider
      t.string :uid
      t.string :email, default: "", null: false
      t.string :encrypted_password, default: "", null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, [ :provider, :uid ], unique: true
    add_index :users, :phone_number, unique: true
    add_index :users, [ :id_number, :id_type ], unique: true, name: "idx_users_id_number_type"
    add_index :users, [ :id_number, :phone_number, :email ], name: "idx_users_search"
  end
end
