namespace :room_create do
  desc "dummy rooms create"
  task :create, [:rooms, :group_id, :user_id, :super_room_id] => :environment do |task, args|
    rooms = args[:rooms].to_i
    group_id = args[:group_id].to_i
    user_id = args[:user_id].to_i
    super_room_id = args[:super_room_id].to_i
    $group = Group.find_by(id: group_id)
    $user = User.find_by(id: user_id)
    if super_room_id != 0
      $super_room = Room.find_by(id: super_room_id).id
    else
      $super_room = 0
    end
    
    rooms.times do |t|
      room = Room.new(
        name: "testroom#{t}",
        group_id: $group.id,
        user_id: $user.id,
        super_room_id: $super_room,
        is_destroyed: false)
      room.icon.attach(
        io: File.open(Rails.root.join("storage/default_room_image.jpg")),
        filename: "default_room_image.jpg",
        content_type: "image/jpg")
      if room.save
        puts "Success testroom#{t} save!"
      else
        puts "Failed testroom#{t} save."
      end
    end
  end

  desc "dummy rooms create in garbage"
  task :create_garbage, [:rooms, :group_id, :user_id, :super_room_id] => :environment do |task, args|
    rooms = args[:rooms].to_i
    group_id = args[:group_id].to_i
    user_id = args[:user_id].to_i
    super_room_id = args[:super_room_id].to_i
    $group = Group.find_by(id: group_id)
    $user = User.find_by(id: user_id)
    if super_room_id != 0
      $super_room = Room.find_by(id: super_room_id).id
    else
      $super_room = 0
    end
    
    rooms.times do |t|
      room = Room.new(
        name: "garbageroom#{t}",
        group_id: $group.id,
        user_id: $user.id,
        super_room_id: $super_room,
        is_destroyed: true)
      room.icon.attach(
        io: File.open(Rails.root.join("storage/default_room_image.jpg")),
        filename: "default_room_image.jpg",
        content_type: "image/jpg")
      if room.save
        puts "Success garbageroom#{t} save!"
      else
        puts "Failed garbageroom#{t} save."
      end
    end
  end
end
