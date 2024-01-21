class Cheer < ApplicationRecord
  belongs_to :user
  belongs_to :goal

  validates :user_id, uniqueness: { scope: :goal_id }
end
