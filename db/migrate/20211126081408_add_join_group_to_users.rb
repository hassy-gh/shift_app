class AddJoinGroupToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :join_group, :boolean, default: false, null: false
  end
end
