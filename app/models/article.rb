class Article < ApplicationRecord
  has_many :comments
  belongs_to :user
  belongs_to :group
  belongs_to :room

  validates :room_id, {presence: true}
  validates :user_id, {presence: true}
  validates :title, {presence: true}
  validates :content, {presence: true}
  validates :comment_count, {presence: true}
  validates :group_id, {presence: true}
  validates :is_solved, inclusion: {in: [true, false]}
  validates :is_destroyed, inclusion: {in: [true, false]}

end
