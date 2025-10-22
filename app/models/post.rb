class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  
  validates :title, presence: true
  validates :content, presence: true
end