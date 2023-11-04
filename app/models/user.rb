class User < ApplicationRecord
  has_many :goals, dependent: :destroy
  has_many :user_flower_images, dependent: :destroy
  has_many :flower_images, through: :user_flower_images, source: :flower_images

  validates :name, presence: true, length: { maximum: 255 }
  validates :line_user_id, presence: true, uniqueness: true, on: :edit

  mount_uploader :avatar, AvatarUploader
end
