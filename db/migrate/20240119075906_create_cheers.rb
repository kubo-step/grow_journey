class CreateCheers < ActiveRecord::Migration[7.0]
  def change
    create_table :cheers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :goal, null: false, foreign_key: true

      t.timestamps
      t.index [:user_id, :goal_id], unique: true
    end
  end
end
