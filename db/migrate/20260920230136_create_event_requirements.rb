class CreateEventRequirements < ActiveRecord::Migration[8.1]
  def change
    create_table :event_requirements, id: :uuid do |t|
      t.references :event, null: false, foreign_key: true, type: :uuid
      t.text :description
      t.decimal :cost_cents
      t.boolean :approved_by_user
      t.datetime :approved_at

      t.timestamps
    end
  end
end
