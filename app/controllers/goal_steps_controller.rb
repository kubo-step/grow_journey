class GoalStepsController < ApplicationController
  include Wicked::Wizard

  steps :add_goal, :add_task, :finished

  def show
    case step
    when :add_goal
      @goal = current_user.goals.new
    when :add_task
      @task = current_user.tasks.new(goal_id: session[:goal_id])
    end
    render_wizard
  end

  def update
    case step
    when :add_goal
      @goal = current_user.goals.new(goal_params)
      @goal.deadline = Date.today + 7.days
      if @goal.save
        session[:goal_id] = @goal.id
        render_wizard @goal
      else
        render step
      end
    when :add_task
      @task = current_user.tasks.new(task_params)
      @task.goal_id = session[:goal_id]
      if @task.save
        render_wizard @task
      else
        render step
      end
    when :finished
      session.delete(:goal_id)
    end
  end

  def finish_wizard_path
    goals_path
  end

  private

  def goal_params
    params.require(:goal).permit(:content, :category_id, :status)
  end

  def task_params
    params.require(:task).permit(:content, :due)
  end
end