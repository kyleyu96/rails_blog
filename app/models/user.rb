class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_secure_password
  validates :username, presence: true,
    uniqueness: { case_sensitive: false },
    length: { minimum: 5, maximum: 30 }
end