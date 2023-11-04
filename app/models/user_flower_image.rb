class UserFlowerImage < ApplicationRecord
  belongs_to :user
  belongs_to :flower_image

  validates :user_id, uniqueness: { scope: :flower_image_id }
end
