class CreatePlans < ActiveRecord::Migration[8.1]
  def change
    create_table :plans, id: :uuid do |t|
      t.string :name
      t.string :target_type
      t.decimal :price_cents
      t.jsonb :features_config

      t.timestamps
    end
  end
end
