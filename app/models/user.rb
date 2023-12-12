class User < ApplicationRecord
  # Deviseによる認証機能を提供するモジュールの設定。OmniAuthを利用したOAuth認証も含む。
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line]

  has_many :goals, dependent: :destroy
  has_many :tasks, through: :goals
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

  # ゲストユーザーを作成する
  def self.guest
    guest_email = "guest_#{SecureRandom.hex(10)}@example.com"
    guest_password = SecureRandom.urlsafe_base64
    guest_uid = SecureRandom.uuid  # 一意のUIDを生成

    create!(uid: guest_uid, provider: "guest_provider") do |user|
      user.email = guest_email
      user.password = guest_password
      user.name = "ゲスト"
    end
  end
end
