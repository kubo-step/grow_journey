# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# ユーザーの作成
user = User.find_or_create_by(email: "sample@example.com") do |u|
  u.password = "sample"
  u.password_confirmation = "sample"
  u.provider = "guest_provider"
  u.uid = "sample@example.com"
  u.name = "サンプル"
end

# ユーザーが正しく作成されたかの確認
if user.persisted?
  puts "ユーザー #{user.email} が作成されました。"
else
  puts "ユーザーの作成に失敗しました: #{user.errors.full_messages.join(', ')}"
end

# カテゴリのサンプルデータを作成
categories = %w[勉強 仕事 趣味 健康 美容 その他]
categories.each do |category_name|
  Category.find_or_create_by(name: category_name)
end

# 目標のサンプルデータを作成
5.times do |i|
  goal = user.goals.create(
    content: "目標 #{i + 1}",
    deadline: Time.zone.now + (i + 1).weeks,
    category: Category.all.sample,
    is_goal: true
  )
end

# タスクのサンプルデータを作成
5.times do |i|
  task = user.goals.create(
    content: "タスク #{i + 1}",
    deadline: Time.zone.now + i.days,
    category: Category.all.sample,
    is_goal: false
  )
end

puts "目標、タスクのサンプルデータを追加しました。"
