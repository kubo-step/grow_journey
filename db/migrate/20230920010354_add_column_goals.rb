class AddColumnGoals < ActiveRecord::Migration[7.0]
  def change
    add_reference :goals, :category, foreign_key: true
  end
end
