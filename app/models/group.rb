class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :rooms
  has_many :articles
  has_many :comments

  has_secure_password

  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  validates :url, {presence: true, uniqueness: true, format: {with: /\A[\w\-_]+\z/}}

end
