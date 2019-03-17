class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :user_id

      t.timestamps
    end
  end
end
