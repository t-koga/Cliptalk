class RemoveUserIdFromGroups < ActiveRecord::Migration[5.2]
  def up
    remove_column :groups, :user_id
  end

  def down
    add_column :groups, :user_id, :integer
  end
end
