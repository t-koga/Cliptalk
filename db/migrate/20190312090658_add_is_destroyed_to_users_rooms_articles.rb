class AddIsDestroyedToUsersRoomsArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_destroyed, :boolean
    add_column :rooms, :is_destroyed, :boolean
    add_column :articles, :is_destroyed, :boolean
  end
end
