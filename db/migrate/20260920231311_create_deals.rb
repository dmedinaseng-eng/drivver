class CreateDeals < ActiveRecord::Migration[8.1]
  def change
    create_table :deals, id: :uuid do |t|
      t.references :vehicle, null: false, foreign_key: { on_delete: :restrict }, type: :uuid
      t.references :organization, foreign_key: { on_delete: :nullify }, type: :uuid
      t.references :agent_seller, foreign_key: { to_table: :users, on_delete: :nullify }, type: :uuid
      t.references :client, null: false, foreign_key: { to_table: :users, on_delete: :restrict }, type: :uuid
      t.references :agent_buyer, foreign_key: { to_table: :users, on_delete: :nullify }, type: :uuid
      t.string :deal_type, null: false
      t.string :status, null: false

      t.timestamps
    end

    add_index :deals, :status
    add_index :deals, :deal_type
  end
end
