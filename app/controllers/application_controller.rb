class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :error
  helper_method :current_user
  helper_method :login_required
  helper_method :logged_in?

  def current_user
    # @current_userがnilでsession[:user_id]に値が入っている場合、ユーザーを持ってくる
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to root_path, warning: 'Please login first.' unless current_user
  end

  def logged_in?
    !current_user.nil?
  end
end
