class GoalsController < ApplicationController
  before_action :find_goal, only: %i[show edit update destroy toggle]
  before_action :load_goals, only: %i[index completed_goals]

  def index
    @goals_count = @goals.where(checked: true).count
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
    render turbo_stream: turbo_stream.remove(@goal)
  end

  def completed_goals;end

  private

  def goal_params
    params.require(:goal).permit(:content, :is_goal, :category_id, :deadline, :status, :checked, :achieved_at, :user_id)
  end

  def find_goal
    @goal = current_user.goals.find(params[:id])
  end

  def load_goals
    @goals = current_user.goals.includes(:category).order(created_at: :desc)
  end
end
