class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :content, presence: true, length: { maximum: 255 }
end
