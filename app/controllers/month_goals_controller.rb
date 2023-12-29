class MonthGoalsController < ApplicationController
  before_action :find_month_goal, only: %i[edit update destroy toggle]

  def new
    @month_goal = Goal.new
  end

  def create
    @month_goal = current_user.goals.build(
      month_goal_params.merge(
        category_id: "1",
        deadline: Date.today,
        goal_type: :monthly
      )
    )

    if @month_goal.save
      redirect_to goals_path, notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @month_goal.update(month_goal_params)
        format.html { redirect_to look_back_path, notice: t(".success") }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @month_goal.destroy!
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to look_back_path }
    end
  end

  private

  def month_goal_params
    params.require(:goal).permit(:content)
  end

  def find_month_goal
    @month_goal = current_user.goals.find(params[:id])
  end
end
