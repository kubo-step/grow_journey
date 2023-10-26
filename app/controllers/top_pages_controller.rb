class TopPagesController < ApplicationController
  def top
    redirect_to goals_path if logged_in?
  end
end
