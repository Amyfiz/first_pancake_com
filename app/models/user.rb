class User < ApplicationRecord
  validates :username, :email, :password, presence: true
  validates :email, uniqueness: true

  has_many :receipts
  has_many :favourites
  has_many :subscriptions, foreign_key:  :follower_id
  has_many :subscriptions, foreign_key:  :follow_id
end