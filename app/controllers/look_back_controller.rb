class LookBackController < ApplicationController
  def index
    @achieved_goals = current_user.goals.includes(:category).achieved_this_month
    @achieved_tasks = current_user.tasks.includes(:goal).achieved_this_month
    @events = @achieved_goals + @achieved_tasks
    @achieved_goal = @achieved_goals.first.content if @achieved_goals.present?
    @achieved_goals_count = @achieved_goals.size

    @month_goal = current_user.goals.monthly.where(deadline: Date.current.beginning_of_month..Date.current.end_of_month).first

    @progress_goals = current_user.goals.includes(:category).where(checked: false)
    @chart_count = @achieved_tasks.count
    @chart_data = Task.joins(goal: :category)
                      .achieved_this_month
                      .group("categories.id", "categories.name")
                      .order("categories.id ASC")
                      .count("tasks.id")
    # カテゴリー名でマッピング
    @chart = @chart_data.map { |(_id, name), count| [name, count] }.to_h
  end
end
