# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# ユーザー作成
user = User.create!(
  username: "テストユーザー1",
  email: "test1@example.com",
  password: "password",
  password_confirmation: "password"
)

user = User.create!(
  username: "テストユーザー2",
  email: "test2@example.com",
  password: "password",
  password_confirmation: "password"
)

# レビュー作成（レビューがUserに紐づいている前提）
Review.create!(
  user_id: 1,
  content: "これはテスト用のレビューです。",
  isbn: "9784088725093"
)

Review.create!(
  user_id: 2,
  content: "これはテスト用のレビューです。",
  isbn: "9784088725444"
)