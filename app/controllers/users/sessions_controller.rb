class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    goals_path
  end

  def guest_sign_in
    @user = User.guest
    sign_in @user
    redirect_to goals_path, notice: "ゲストユーザーとしてログインしました。"
  end
end
