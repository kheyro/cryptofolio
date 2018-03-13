class AddRoleIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role_id, :boolean, default: 0
  end
end
