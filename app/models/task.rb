class Task < ApplicationRecord
  belongs_to :goal

  validates :content, presence: true, length: { maximum: 255 }
  validates :due, presence: true

  def toggle_checked!(current_user, selected_image)
    Task.transaction do
      update!(checked: !checked, achieved_at: Date.today)
      handle_flower_image(current_user, selected_image) if checked
      goal.check_completion
    end
  end

  # simple_calendar用のメソッド
  def start_time
    self.achieved_at
  end

  private

  def handle_flower_image(current_user, selected_image)
    flower_image = FlowerImage.find_by(flower_url: selected_image)
    if flower_image
      @user_flower_image = UserFlowerImage.find_or_initialize_by(user: current_user, flower_image_id: flower_image.id)
      @user_flower_image.unlocked = true
      @user_flower_image.save
    end
  end
end
