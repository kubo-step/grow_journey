class RemoveIsGoalFromGoals < ActiveRecord::Migration[7.0]
  def change
    remove_column :goals, :is_goal, :boolean
  end
end
