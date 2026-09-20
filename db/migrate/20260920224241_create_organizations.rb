class CreateOrganizations < ActiveRecord::Migration[8.1]
  def change
    create_table :organizations, id: :uuid do |t|
      t.string :name
      t.string :tax_id
      t.string :org_type
      t.string :phone_number
      t.string :phone_country_code
      t.string :email

      t.timestamps
    end
    add_index :organizations, :tax_id
    add_index :organizations, :name
    add_index :organizations, :org_type
    add_index :organizations, :email
    add_index :organizations, :phone_number
  end
end
