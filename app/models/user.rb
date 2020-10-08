require 'regexp_collect'

class User < ApplicationRecord
  include RegexpCollect
  before_save { self.email = email.downcase }

  validates :username, presence: {message: "用户名不能为空"}, length: {maximum: 50}
  validates :username, uniqueness: {message: "用户名已存在"}
  validates :password, presence: {message: "密码不能为空"}
  validates :password, length: {minimum: 6, message: "密码长度最短为6位"}
  validates :email, format: RegexpCollect::EMAIL, if: -> { email.present? },
            uniqueness: {case_sensitive: true}

  has_many :blogs
  has_and_belongs_to_many :tags
end
