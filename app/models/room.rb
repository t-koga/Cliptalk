class Room < ApplicationRecord
  has_one_attached :icon

  validates :name, {presence: true, uniqueness: {scope: :super_room_id}}
  validates :user_id, {presence: true}
  validates :super_room_id, {presence: true}
  validate :validate_icon

  def user
    return User.find_by(id: self.user_id)
  end

  def thumbnail_small
    return self.icon.variant(resize: "50x50").processed
  end

  def thumbnail_large
    return self.icon.variant(resize: "100x100").processed
  end

  def validate_icon
    if icon.blob.byte_size > 100.kilobytes
      icon.purge
      errors.add(:icon, "のファイル容量が大きすぎます")
    elsif !image?
      icon.purge
      errors.add(:icon, "はjpg, jpeg, gif, pngのいずれかを選択してください")
    end
  end

  def image?
    %w[image/jpg image/jpeg image/gif image/png].include?(icon.blob.content_type)
  end

end
