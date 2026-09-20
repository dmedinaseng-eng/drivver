class CreateFeatures < ActiveRecord::Migration[8.1]
  def change
    create_table :features, id: :uuid do |t|
      t.string :name
      t.string :category
      t.string :target_model
      t.text :description

      t.timestamps
    end
    add_index :features, :name
    add_index :features, :category
    add_index :features, :target_model
  end
end
