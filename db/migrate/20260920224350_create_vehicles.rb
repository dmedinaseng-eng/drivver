class CreateVehicles < ActiveRecord::Migration[8.1]
  def change
    create_table :vehicles, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :family, null: false, foreign_key: true, type: :uuid
      t.string :plate
      t.string :color
      t.string :chasis_id
      t.string :motor_id
      t.string :vehicle_type
      t.string :brand
      t.string :model
      t.string :year

      t.timestamps
    end
    add_index :vehicles, :plate, unique: true
    add_index :vehicles, :chasis_id, unique: true
    add_index :vehicles, :motor_id, unique: true
    add_index :vehicles, :vehicle_type
    add_index :vehicles, :brand
    add_index :vehicles, :model
  end
end
