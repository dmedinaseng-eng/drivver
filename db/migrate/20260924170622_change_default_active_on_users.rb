class ChangeDefaultActiveOnUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_default :users, :active, from: nil, to: false
    reversible do |dir|
      dir.up do
        User.where(active: nil).update_all(active: false)
      end
    end
  end
end