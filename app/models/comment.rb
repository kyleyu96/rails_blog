class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  validates :description, presence: true, length: { maximum: 150 }
  validates :user_id, presence: true
  validates :article_id, presence: true
  default_scope -> { order(updated_at: :desc) }
end