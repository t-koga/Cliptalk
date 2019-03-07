class AddCommentCountToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :comment_count, :integer
  end
end
