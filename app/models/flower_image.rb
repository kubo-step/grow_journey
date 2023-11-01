class FlowerImage < ApplicationRecord
  has_many :user_flower_images
  has_many :users, through: :user_flower_images
end
