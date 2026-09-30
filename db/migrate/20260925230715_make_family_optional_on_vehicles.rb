class MakeFamilyOptionalOnVehicles < ActiveRecord::Migration[8.1]
  def change
    change_column_null :vehicles, :family_id, true
  end
end
