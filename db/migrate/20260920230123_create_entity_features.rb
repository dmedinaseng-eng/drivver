class CreateEntityFeatures < ActiveRecord::Migration[8.1]
  def change
    create_table :entity_features, id: :uuid do |t|
      t.references :feature, null: false, foreign_key: true, type: :uuid
      t.references :featurable, polymorphic: true, null: false, type: :uuid

      t.timestamps
    end
  end
end
