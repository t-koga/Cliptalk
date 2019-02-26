class Comment < ApplicationRecord
  validates :article_id, {presence: true}
  validates :user_id, {presence: true}
  validates :content, {presence: true}

end
