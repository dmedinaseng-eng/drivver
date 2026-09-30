class CreateCrmCustomers < ActiveRecord::Migration[8.1]
  def change
    create_table :crm_customers, id: :uuid do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :cascade }, type: :uuid
      t.string :lead_type, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone_number, null: false
      t.string :phone_country_code, null: false
      t.string :email
      t.text :notes
      t.references :converted_user, foreign_key: { to_table: :users, on_delete: :nullify }, type: :uuid

      t.timestamps
    end
    add_index :crm_customers, :lead_type
    add_index :crm_customers, :first_name
    add_index :crm_customers, :last_name
    add_index :crm_customers, :phone_number
    add_index :crm_customers, :phone_country_code
    add_index :crm_customers, :email
  end
end
