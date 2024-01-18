class TasksController < ApplicationController
  before_action :find_goal, only: %i[new create]
  before_action :find_task, only: %i[edit update destroy toggle copy]
  before_action :tasks_all, only: %i[create update copy]

  def new
    @task = @goal.tasks.build
  end

  def create
    @task = @goal.tasks.build(task_params)
    @tab = "tab1"
    respond_to do |format|
      if @task.save
        @goal = @task.goal
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
      if @task.update(task_params)
        format.html { redirect_to goals_path, notice: t(".success") }
        format.turbo_stream { flash.now[:success] = t("defaults.message.updated") }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy!
    @goal = @task.goal
    flash.now[:success] = t("defaults.message.deleted")
  end

  def toggle
    @task.toggle_checked!(current_user, session[:selected_image])

    if @task.goal.checked
      render turbo_stream: turbo_stream.remove(@task.goal)
    else
      render turbo_stream: turbo_stream.remove(@task)
    end
  end

  def copy
    @copy_task = @task.dup
    @tab = "tab1"
    respond_to do |format|
      if @copy_task.save
        @goal = @copy_task.goal
        format.html { redirect_to goals_path, notice: t(".success") }
        format.turbo_stream { flash.now[:success] = t("defaults.message.updated") }
      else
        format.html { redirect_to goals_path, status: :unprocessable_entity }
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:content, :due, :goal_id)
  end

  def find_goal
    @goal = Goal.find(params[:goal_id])
  end

  def find_task
    @task = current_user.tasks.find(params[:id])
  end

  def tasks_all
    @tasks = current_user.tasks.includes(:goal).order(due: :asc)
  end
end
