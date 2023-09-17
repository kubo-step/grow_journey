class CreateGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.string :content,  null: false
      t.boolean :is_goal, default: false
      t.datetime :deadline, null: false
      t.boolean :status , default: false
      t.boolean :checked, default: false
      t.datetime :achieved_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
