class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events, id: :uuid do |t|
      t.references :vehicle, null: false, foreign_key: true, type: :uuid
      t.references :organization, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :event_type
      t.string :status
      t.boolean :custody_flag
      t.decimal :price_cents

      t.timestamps
    end
    add_index :events, :status
    add_index :events, :event_type
  end
end
