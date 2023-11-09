class FlowerController < ApplicationController
  def index
    @flower_images = FlowerImage.all
    @user_flower_image = current_user.user_flower_images
  end
end
