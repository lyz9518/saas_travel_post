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



movies = [
  { title: 'Aladdin', rating: 'G', release_date: '25-Nov-1992' },
  { title: 'The Terminator', rating: 'R', release_date: '26-Oct-1984' },
  { title: 'When Harry Met Sally', rating: 'R', release_date: '21-Jul-1989' },
  { title: 'The Help', rating: 'PG-13', release_date: '10-Aug-2011' },
  { title: 'Chocolat', rating: 'PG-13', release_date: '5-Jan-2001' },
  { title: 'Amelie', rating: 'R', release_date: '25-Apr-2001' },
  { title: '2001: A Space Odyssey', rating: 'G', release_date: '6-Apr-1968' },
  { title: 'The Incredibles', rating: 'PG', release_date: '5-Nov-2004' },
  { title: 'Raiders of the Lost Ark', rating: 'PG', release_date: '12-Jun-1981' },
  { title: 'Chicken Run', rating: 'G', release_date: '21-Jun-2000' },
]

movies.each do |movie|
  Movie.create!(movie)
end
