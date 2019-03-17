class AddGroupIdToUsersRoomsArticlesComments < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :group_id, :integer
    add_column :rooms, :group_id, :integer
    add_column :articles, :group_id, :integer
    add_column :comments, :group_id, :integer
  end
end
