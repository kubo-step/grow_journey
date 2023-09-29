class GoalsController < ApplicationController
  before_action :find_goal, only: %i[show edit update destroy]

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
      flash.now.notice = "登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @goal.update(goal_params)
      flash.now.notice = "ねこを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @goal.destroy!
    flash.now.notice = "削除しました"
  end

  private

  def goal_params
    params.require(:goal).permit(:content, :is_goal,:name, :category_id, :deadline, :status, :checked, :achieved_at, :user_id)
  end

  def find_goal
    @goal = current_user.goals.find(params[:id])
  end
end
