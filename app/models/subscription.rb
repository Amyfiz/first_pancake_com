class Subscription < ApplicationRecord
  belongs_to :follow_id, :class_name => "User"
  belongs_to :follower_id, :class_name => "User"
end