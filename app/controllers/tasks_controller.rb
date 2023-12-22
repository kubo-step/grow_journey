class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_image, only: %i[completed_tasks]
  before_action :find_goal, only: %i[new create]
  before_action :find_task, only: %i[destroy toggle]

  def new
    @task = @goal.tasks.build
  end

  def create
    @task = @goal.tasks.build(task_params)
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

  def set_image
    images = ["flower01_cherry_blossoms.gif", "flower02_marigold.gif", "flower03_himejoon.gif", "flower04_sunflower.gif",
              "flower05_gerbera.gif"
            ]
    @image = images.sample
    session[:selected_image] = @image
  end
end
