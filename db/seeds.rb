# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |i|
  user = User.create(name: "name#{i}", email: "name#{i}@mail", password: "name#{i}")
  user.avatar.attach(io: File.open(Rails.root.join("storage/default_image.jpg")), filename: "default_image.jpg", content_type: "image/jpg")
end

5.times do |i|
  room = Room.create(name: "room#{i}", user_id: "#{i+1}", super_room_id: 0)
  room.icon.attach(io: File.open(Rails.root.join("storage/default_room_image.jpg")), filename: "default_room_image.jpg", content_type: "image/jpg")
end