class Subscription < ApplicationRecord
  #belongs_to :follow_id, :class_name => "User"
  belongs_to :user, foreign_key: :follow_id
end