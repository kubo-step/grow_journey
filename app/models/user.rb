class User < ApplicationRecord
  # Deviseによる認証機能を提供するモジュールの設定。OmniAuthを利用したOAuth認証も含む。
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line]

  has_many :goals, dependent: :destroy
  has_many :user_flower_images, dependent: :destroy
  has_many :flower_images, through: :user_flower_images, source: :flower_images

  validates :name, presence: true, length: { maximum: 255 }
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }

  mount_uploader :avatar, AvatarUploader

  # OmniAuthデータからユーザーのアクセストークンを更新する
  # 保存はUsers::OmniauthCallbacksControllerで行われるため、ここでは save は呼ばない。
  def refresh_access_token(omniauth)
    # 提供されたomniauthデータが現在のユーザーのものであることを確認
    return if provider.to_s != omniauth["provider"].to_s || uid != omniauth["uid"]

    access_token = omniauth["credentials"]["refresh_token"]
    access_secret = omniauth["credentials"]["secret"]
    credentials = omniauth["credentials"].to_json
    name = omniauth["info"]["name"]
  end
end
