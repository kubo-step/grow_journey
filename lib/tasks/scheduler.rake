namespace :scheduler do
  desc "Check goals and tasks deadline and send LINE notifications"
  task send_line_notifications: :environment do
    client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end

    # 全ユーザーをループ処理
    User.find_each do |user|
      today_beginning = Time.zone.today.beginning_of_day
      today_end = Time.zone.today.end_of_day

      goals = user.goals.where(deadline: today_beginning..today_end, checked: false).map(&:content)
      tasks = user.tasks.where(due: today_beginning..today_end, checked: false).map(&:content)

      message_text = ""
      if goals.any? || tasks.any?
        message_text += "🌟 本日クリア予定の目標・タスクのお知らせ 🌟\n"
        message_text += "目標:\n・#{goals.join("\n・")}\n" if goals.any?
        message_text += "タスク:\n・#{tasks.join("\n・")}\n" if tasks.any?
        message_text += "\n毎日の小さな一歩が、大きな成長へと繋がります。\n今日も一歩前進しましょう！🚶‍♀️"
      end

      if message_text.present?
        message = {
          type: "text",
          text: message_text
        }
        response = client.push_message(user.uid, message)
        puts response
      end
    end
  end
end