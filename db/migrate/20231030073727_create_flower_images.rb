class CreateFlowerImages < ActiveRecord::Migration[7.0]
  def change
    create_table :flower_images do |t|
      t.string :flower_language
      t.string :flower_season
      t.string :flower_name
      t.string :flower_url

      t.timestamps
    end
  end
end
