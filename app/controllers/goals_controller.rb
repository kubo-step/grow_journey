class GoalsController < ApplicationController
  before_action :find_goal, only: %i[show edit update destroy toggle]

  def index
    @goals = current_user.goals.includes(:category).order(created_at: :desc)
  end

  def show;end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.build(goal_params)
    if @goal.save
      flash.now[:success] = t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @goal.update(goal_params)
      flash.now[:success] = "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @goal.destroy
    flash.now[:success] = "削除しました"
  end

  def toggle
    @goal.update(checked: !@goal.checked)
    if @goal.checked
      render turbo_stream: turbo_stream.remove(@goal)
    else
      render turbo_stream: turbo_stream.update(@goal, partial: 'goal')
    end
  end

  def completed_goals
    @goals = current_user.goals.includes(:category).order(created_at: :desc)
  end

  private

  def goal_params
    params.require(:goal).permit(:content, :is_goal, :category_id, :deadline, :status, :checked, :achieved_at, :user_id)
  end

  def find_goal
    @goal = current_user.goals.find(params[:id])
  end
end
