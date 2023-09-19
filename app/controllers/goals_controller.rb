class GoalsController < ApplicationController
  def index
    @goals = Goal.all.includes(:user).order(created_at: :desc)
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.build(goal_params)
    @goal.save
  end

  private

  def goal_params
    params.require(:goal).permit(:content, :is_goal, :deadline, :status, :checked, :achieved_at)
  end
end
