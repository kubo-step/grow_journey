class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :content, null: false
      t.datetime :due, null: false
      t.boolean :checked, default: false
      t.datetime :achieved_at
      t.references :goal, null: false, foreign_key: true

      t.timestamps
    end
  end
end