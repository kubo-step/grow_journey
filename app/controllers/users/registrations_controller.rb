# frozen_string_literal: true

# Users::RegistrationsControllerはDeviseを継承しており、
# ユーザーの登録をカスタマイズします。
class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  def create
    @user = User.new(create_users_params)
    if @user.save
      sign_in(@user)
      redirect_to goals_path, notice: t(".success")
    else
      flash.now[:alert] = t(".fail")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def create_users_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
          .merge(provider: "email", uid: SecureRandom.uuid)
  end
end
