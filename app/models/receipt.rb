class Receipt < ApplicationRecord
  validates :title, :description, presence: true

  belongs_to :user
  has_many :favourites
  has_and_belongs_to_many :categories

  def self.add_recipe(title, description, photo)
    create(title: title, description: description)
    puts "Recipe successfully added!"
  rescue => e
    puts e.message
  end
end