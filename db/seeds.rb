# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.destroy_all
# User.destroy_all

name = Array.new
name = ["財經類", "商業類", "技術類"]

name.each do |name|
  Category.create!(name: name)
end

puts Category.count

User.create!(
  name: "manager",
  email: "admin@example.com",
  password: "12345678",
  role: "admin",
  )