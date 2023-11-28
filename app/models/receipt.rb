class Receipt < ApplicationRecord
  validates :title, :description, presence: true

  belongs_to :user
  has_many :favourites
  has_and_belongs_to_many :categories
end