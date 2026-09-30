class CreateOffers < ActiveRecord::Migration[8.1]
  def change
    create_table :offers, id: :uuid do |t|
      t.references :deal, null: false, foreign_key: { on_delete: :cascade }, type: :uuid
      t.references :offeror_user, null: false, foreign_key: { to_table: :users, on_delete: :restrict }, type: :uuid
      t.references :organization, foreign_key: { on_delete: :nullify }, type: :uuid
      t.decimal :amount_cents, null: false
      t.string :status, null: false

      t.timestamps
    end
    add_index :offers, :status
    add_index :offers, :amount_cents
  end
end
