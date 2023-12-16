class Task < ApplicationRecord
  belongs_to :goal

  validates :content, presence: true, length: { maximum: 255 }
  validates :due, presence: true
end
