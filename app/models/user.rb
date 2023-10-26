class User < ApplicationRecord
  has_many :goals, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :line_user_id, presence: true, on: :edit

  mount_uploader :avatar, AvatarUploader
end
