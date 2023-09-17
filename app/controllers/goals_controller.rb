class GoalsController < ApplicationController
  def index
    @goals = Goal.all.includes(:user).order(created_at: :desc)
  end
end
