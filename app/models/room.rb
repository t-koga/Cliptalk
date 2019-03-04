class Room < ApplicationRecord
  has_one_attached :icon

  validates :name, {presence: true, uniqueness: {scope: :super_room_id}}
  validates :user_id, {presence: true}
  validates :super_room_id, {presence: true}

  def user
    return User.find_by(id: self.user_id)
  end

end
