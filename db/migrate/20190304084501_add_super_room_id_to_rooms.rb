class AddSuperRoomIdToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :super_room_id, :integer
  end
end
