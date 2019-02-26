class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.integer :room_id
      t.integer :user_id
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
