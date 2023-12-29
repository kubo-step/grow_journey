class AddColumnToGoals < ActiveRecord::Migration[7.0]
  def change
    add_column :goals, :goal_type, :integer, default: 0
  end
end
