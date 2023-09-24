class GoalsController < ApplicationController
  before_action :find_goal, only: [:edit, :update, :destroy]

  def index
    @goals = current_user.goals.includes(:category).order(created_at: :desc)
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.build(goal_params)
    @goal.is_goal = true
    @task = current_user.goals.build(goal_params)
    @task.is_goal = false
    if @goal.save
      redirect_to goals_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @goal.update(goal_params)
      redirect_to goals_path, success: t('defaults.message.updated', item: Goal.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @goal.destroy!
    redirect_to goals_path, success: t('defaults.message.deleted', item: Goal.model_name.human)
  end

  private

  def goal_params
    params.require(:goal).permit(:content, :is_goal, :category_id, :deadline, :status, :checked, :achieved_at, :user_id)
  end

  def find_goal
    @goal = current_user.goals.find(params[:id])
  end
end
