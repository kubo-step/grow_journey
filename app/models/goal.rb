class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :tasks, dependent: :destroy

  validates :content, presence: true, length: { maximum: 255 }
  validates :category_id, presence: { message: 'を選択してください' }

  # ゴールに紐づく全タスクが完了していればゴールを完了とし、一つでも未完了があれば未完了とする。
  def check_completion
    update(checked: tasks.where.not(checked: true).empty?)
  end
end
