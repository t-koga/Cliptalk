class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar

  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  validate :validate_avatar


  def thumbnail_small
    return self.avatar.variant(resize: "50x50").processed
  end

  def thumbnail_large
    return self.avatar.variant(resize: "100x100").processed
  end

  def validate_avatar
    if avatar.blob.byte_size > 100.kilobytes
      avatar.purge
      errors.add(:avatar, "のファイル容量が大きすぎます")
    elsif !image?
      avatar.purge
      errors.add(:avatar, "はjpg, jpeg, gif, pngのいずれかを選択してください")
    end
  end

  def image?
    %w[image/jpg image/jpeg image/gif image/png].include?(avatar.blob.content_type)
  end

end
