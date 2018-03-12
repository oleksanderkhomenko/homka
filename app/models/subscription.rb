class Subscription < ApplicationRecord
  belongs_to :idol, :class_name => 'User'
  belongs_to :follower, :class_name => 'User'
  validates :follower_id, uniqueness: { scope: :idol_id }
end
