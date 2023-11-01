class UsersController < ApplicationController
  require 'net/http'
  require 'uri'

  def new
    redirect_to goals_path if current_user
    gon.liff_id = ENV.fetch('LIFF_ID', nil)
  end

  def create
    id_token = params[:idToken]
    channel_id = ENV.fetch('LINE_CHANNEL_ID', nil)
    #IDトークンを検証し、ユーザーの情報を取得
    res = Net::HTTP.post_form(URI.parse('https://api.line.me/oauth2/v2.1/verify'), { 'id_token' => id_token, 'client_id' => channel_id })
    line_user_id = JSON.parse(res.body)['sub']
    user = User.find_by(line_user_id:)
    name = params[:name]
    if user.nil?
      user = User.create(line_user_id: line_user_id, name: name)
    elsif (session[:user_id] = user.id)
      render json: user
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: t('.success')
  end

  def flowers
    @flower_images = FlowerImage.all
    @user_flower_image = current_user.user_flower_images
  end
end
