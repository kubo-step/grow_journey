class UserFlowerImage < ApplicationRecord
  belongs_to :user
  belongs_to :flower_image
end
