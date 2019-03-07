class Comment < ApplicationRecord
  validates :article_id, {presence: true}
  validates :user_id, {presence: true}
  validates :content, {presence: true}

  def user
    return User.find_by(id: self.user_id)
  end

  def article
    return Article.find_by(id: self.article_id)
  end

end
