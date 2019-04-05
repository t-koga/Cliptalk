class User < ApplicationRecord
  has_many :rooms
  has_many :articles
  has_many :comments
  belongs_to :group

  # 最大100文字
  validates :name, {presence: true, length: {maximum: 100}}
  # 最大255文字,同グループ内で重複不可
  validates :email, {presence: true, uniqueness: {scope: :group_id}, length: {maximum: 255}}
  validates :group_id, {presence: true}
  validates :is_destroyed, inclusion: {in: [true, false]}
  validate :validate_avatar
  has_secure_password
  # 最大20文字
  validates :password, {length: {maximum: 20}}
  has_one_attached :avatar

  paginates_per 30


  def thumbnail_small
    self.avatar.variant(resize: "50x50").processed
  end

  def thumbnail_large
    self.avatar.variant(resize: "100x100").processed
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
