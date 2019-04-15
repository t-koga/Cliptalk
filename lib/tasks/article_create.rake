namespace :article_create do
  desc "dummy articles create"
  task :create, [:articles, :group_id, :user_id, :room_id] => :environment do |task, args|
    articles = args[:articles].to_i
    group_id = args[:group_id].to_i
    user_id = args[:user_id].to_i
    room_id = args[:room_id].to_i
    $group = Group.find_by(id: group_id)
    $user = User.find_by(id: user_id)
    $room = Room.find_by(id: room_id)
    
    articles.times do |t|
      article = Article.new(
        group_id: $group.id,
        user_id: $user.id,
        room_id: $room.id,
        title: "testclip#{t}",
        content: "test",
        comment_count: 0,
        is_solved: false,
        is_destroyed: false)
      if article.save
        puts "Success testclip#{t} save!"
      else
        puts "Failed testclip#{t} save."
      end
    end
  end
end
