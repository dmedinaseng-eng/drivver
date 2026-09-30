class CreateOrganizationRoles < ActiveRecord::Migration[8.1]
  def change
    create_table :organization_roles, id: :uuid do |t|
      t.references :organization, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :role_name
      t.jsonb :permissions

      t.timestamps
    end
  end
end
