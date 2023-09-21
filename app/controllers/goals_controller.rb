class GoalsController < ApplicationController
  def index
    @goals = current_user.goals.includes(:category).order(created_at: :desc)
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.build(goal_params)
    @goal.is_goal = true
    if @goal.save
      redirect_to goals_path
    else
      render :new
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:content, :is_goal, :category_id, :deadline, :status, :checked, :achieved_at, :user_id)
  end
end
