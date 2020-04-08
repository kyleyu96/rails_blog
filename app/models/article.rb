class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :body, presence: true, length: { minimum: 50 }
  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }
end