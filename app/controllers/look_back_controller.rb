class LookBackController < ApplicationController
  def index
    @achieved_goals = current_user.goals.includes(:category).where(checked: true)
    @achieved_tasks = current_user.tasks.includes(:goal).where(checked: true)
    @events = @achieved_goals + @achieved_tasks
  end
end
