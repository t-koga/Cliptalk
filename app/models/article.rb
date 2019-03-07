class Article < ApplicationRecord
  validates :room_id, {presence: true}
  validates :user_id, {presence: true}
  validates :title, {presence: true}
  validates :content, {presence: true}
  validates :comment_count, {presence: true}

  def user
    return User.find_by(id: self.user_id)
  end

end
