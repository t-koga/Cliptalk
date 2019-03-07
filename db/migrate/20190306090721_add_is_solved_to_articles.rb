class AddIsSolvedToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :is_solved, :boolean
  end
end
