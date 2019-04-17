namespace :user_create do
  desc "dummy users create"
  task :create, [:users, :group_id] => :environment do |task, args|
    users = args[:users].to_i
    id = args[:group_id].to_i
    $group = Group.find_by(id: id)
    
    users.times do |t|
      user = User.new(
        name: "testuser#{t}",
        email: "testuser#{t}@mail",
        password: "testuser",
        password_confirmation: "testuser",
        group_id: $group.id,
        is_destroyed: false)
      user.avatar.attach(
        io: File.open(Rails.root.join("storage/default_image.jpg")),
        filename: "default_image.jpg",
        content_type: "image/jpg")
      if user.save
        puts "Success testuser#{t} save!"
      else
        puts "Failed testuser#{t} save."
      end
    end
  end

  desc "dummy users create in garbage"
  task :create_garbage, [:users, :group_id] => :environment do |task, args|
    users = args[:users].to_i
    id = args[:group_id].to_i
    $group = Group.find_by(id: id)
    
    users.times do |t|
      user = User.new(
        name: "garbageuser#{t}",
        email: "garbageuser#{t}@mail",
        password: "testuser",
        password_confirmation: "testuser",
        group_id: $group.id,
        is_destroyed: true)
      user.avatar.attach(
        io: File.open(Rails.root.join("storage/default_image.jpg")),
        filename: "default_image.jpg",
        content_type: "image/jpg")
      if user.save
        puts "Success garbageuser#{t} save!"
      else
        puts "Failed garbageuser#{t} save."
      end
    end
  end
end
