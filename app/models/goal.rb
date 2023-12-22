class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :tasks, dependent: :destroy

  validates :content, presence: true, length: { maximum: 255 }
  validates :category_id, presence: { message: 'を選択してください' }

  def check_completion
    update(checked: tasks.all? { |task| task.checked })
  end
end
