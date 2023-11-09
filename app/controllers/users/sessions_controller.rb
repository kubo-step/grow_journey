# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  def guest_sign_in
    @user = User.guest
    sign_in @user
    redirect_to goals_path, notice: "ゲストユーザーとしてログインしました。"
  end
end
