class AddUrlToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :url, :string
  end
end
