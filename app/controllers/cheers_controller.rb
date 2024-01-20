class CheersController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    cheer_goal = Goal.find(params[:goal_id])
    current_user.cheer(cheer_goal)
    redirect_back fallback_location: goals_path
  end

  def destroy
    cheer_goal = current_user.cheers.find(params[:id]).goal
    current_user.uncheer(cheer_goal)
    redirect_back fallback_location: goals_path
  end
end
