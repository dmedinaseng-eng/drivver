class CreateFamilyMembers < ActiveRecord::Migration[8.1]
  def change
    create_table :family_members, id: :uuid do |t|
      t.references :family, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :status
      t.string :role

      t.timestamps
    end
  end
end
