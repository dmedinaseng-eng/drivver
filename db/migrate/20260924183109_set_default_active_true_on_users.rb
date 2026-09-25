class SetDefaultActiveTrueOnUsers < ActiveRecord::Migration[8.1]
  def change
    change_column_default :users, :active, from: false, to: true

    reversible do |dir|
      dir.up do
        User.where(active: [nil, false]).update_all(active: true)
      end
    end
  end
end