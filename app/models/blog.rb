class Blog < ApplicationRecord
  validates :title, presence: {message: "标题不能为空"}
  validates :content, presence: {message: "内容已存在"}

  belongs_to :user
end
