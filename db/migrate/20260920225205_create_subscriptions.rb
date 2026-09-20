class CreateSubscriptions < ActiveRecord::Migration[8.1]
  def change
    create_table :subscriptions, id: :uuid do |t|
      t.references :subscribable, polymorphic: true, null: false, type: :uuid
      t.references :plan, null: false, foreign_key: true, type: :uuid
      t.string :status
      t.date :expires_at

      t.timestamps
    end
  end
end
