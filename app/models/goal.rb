class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :content, presence: true, length: { maximum: 255 }

  def is_goal?
    self.is_goal == true
  end

  def is_task?
    self.is_goal == false
  end
end
