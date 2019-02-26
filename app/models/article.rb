class Article < ApplicationRecord
  validates :room_id, {presence: true}
  validates :user_id, {presence: true}
  validates :title, {presence: true}
  validates :content, {presence: true}

end
