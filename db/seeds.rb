# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

posts = [
  { zipcode: '10463', creator_id: '1', title: "Check out Here!", description: 'hello world', date: '2022-01-01'},
  { zipcode: '10464', creator_id: '1', title: "You don't wanna miss this", description: 'Hi welcome', date: '2022-01-01'},
  { zipcode: '10463', creator_id: '2', title: "I had so much fun here", description: 'hello USA', date: '2022-01-02'}
]

users = [
  { user_name: "lion", first_name: "John", last_name: "Smith", password: "123"},
  { user_name: "king", first_name: "Adam", last_name: "Mctigue", password: "123"}
]

posts.each do |post|
  Post.create!(post)
end

users.each do |user|
  User.create!(user)
end

