class AddCurrentContextToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :current_context, :string
  end
end
