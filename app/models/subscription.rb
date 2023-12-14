class Subscription < ApplicationRecord
  belongs_to :follow_id, :class_name => "User", foreign_key: "follow_id"
  belongs_to :follower_id, :class_name => "User", foreign_key: "follower_id"
end