class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :tasks, dependent: :destroy
  has_many :cheers, dependent: :destroy

  enum goal_type: { weekly: 0, monthly: 1 }
  scope :achieved_this_month, -> { where(checked: true, achieved_at: Date.current.beginning_of_month..Date.current.end_of_month) }

  validates :content, presence: true, length: { maximum: 255 }
  validates :category_id, presence: { message: 'を選択してください' }

  # ゴールに紐づく全タスクが完了していればゴールを完了とし、一つでも未完了があれば未完了とする。
  def check_completion
    if tasks.where.not(checked: true).empty?
      update(checked: true, achieved_at: Date.today)
    else
      update(checked: false)
    end
  end

  def progress
    total_tasks.zero? ? 0 : (completed_tasks.to_f / total_tasks * 100).round
  end

  def total_tasks
    self.tasks.count
  end

  # ゴールに紐づく完了したタスクの数を返す
  def completed_tasks
    self.tasks.where(checked: true).count
  end

  # simple_calendar用のメソッド
  def start_time
    self.achieved_at
  end
end
