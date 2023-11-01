class CreateUserFlowerImages < ActiveRecord::Migration[7.0]
  def change
    create_table :user_flower_images do |t|
      t.references :user, null: false, foreign_key: true
      t.references :flower_image, null: false, foreign_key: true
      t.boolean :unlocked

      t.timestamps
    end
  end
end
