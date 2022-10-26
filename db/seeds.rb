# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

posts = [
  { post_id: '1', zipcode: '10463', creator_id: '1', description: 'hello world' }
  { post_id: '2', zipcode: '10464', creator_id: '1', description: 'Hi welcome' }
  { post_id: '3', zipcode: '10463', creator_id: '2', description: 'hello USA' }
]

posts.each do |post|
  Post.create!(post)
end
