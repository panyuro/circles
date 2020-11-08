require 'regexp_collect'

class User < ApplicationRecord
  include RegexpCollect

  has_many :blogs
  has_and_belongs_to_many :tags

  validates :username, presence: {message: "用户名不能为空"}, length: {maximum: 50},
            uniqueness: {message: "用户名已存在"}
  validates :email, format: RegexpCollect::EMAIL, if: -> { email.present? },
            uniqueness: {case_sensitive: true}
  has_secure_password
  validates :password, presence: true,
            length: {minimum: 6, message: "密码长度最短为6位"}
  validates_confirmation_of :password
  before_save { self.email = email.downcase }

  # 返回指定字符串的哈希摘要
  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost
  end
end
