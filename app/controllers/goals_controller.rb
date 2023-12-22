class GoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_goal, only: %i[show edit update destroy toggle]
  before_action :load_goals, only: %i[index completed_goals]
  before_action :set_image, only: %i[index completed_goals]

  def index
    @goals_count = @tasks.where(checked: true).count
    @goals_count_modal = @goals_count + 1
  end

  def show; end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.build(goal_params)
    respond_to do |format|
      if @goal.save
        format.html { redirect_to goals_path, notice: t(".success") }
        format.turbo_stream { flash.now[:success] = t(".success") }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to goals_path, notice: t(".success") }
        format.turbo_stream { flash.now[:success] = t("defaults.message.updated") }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @goal.destroy!
    flash.now[:success] = t("defaults.message.deleted")
  end

  def toggle
    @goal.toggle_checked!(current_user, session[:selected_image])
    render turbo_stream: turbo_stream.remove(@goal)
  end

  def completed_goals; end

  private

  def goal_params
    params.require(:goal).permit(:content, :is_goal, :category_id, :deadline, :status, :checked, :achieved_at, :user_id)
  end

  def find_goal
    @goal = current_user.goals.find(params[:id])
  end

  def load_goals
    @goals = current_user.goals.includes(:category).order(created_at: :desc)
    @tasks = current_user.tasks.includes(:goal).order(due: :asc)
    @task = Task.new
  end

  def set_image
    images = ["flower01_cherry_blossoms.gif", "flower02_marigold.gif", "flower03_himejoon.gif", "flower04_sunflower.gif",
              "flower05_gerbera.gif"
            ]
    @image = images.sample
    session[:selected_image] = @image
  end
end
