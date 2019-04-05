class Group < ApplicationRecord
  has_many :users
  has_many :rooms
  has_many :articles
  has_many :comments

  # 最大100文字
  validates :name, {presence: true, length: {maximum: 100}}
  # 最大255文字,重複不可
  validates :email, {presence: true, uniqueness: true, length: {maximum: 255}}
  # 最大255文字,重複不可,使用できる文字[半角英数字,ハイフン(-),アンダーバー(_)]
  validates :url, {presence: true, uniqueness: true, format: {with: /\A[\w\-_]+\z/}, length: {maximum: 255}}
  has_secure_password
  # 最大20文字
  validates :password, {length: {maximum: 20}}

end
