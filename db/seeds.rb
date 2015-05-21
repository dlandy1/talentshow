# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
 # Create Users

 5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.save
end
users = User.all

30.times do
   post = Post.create!(
    user:    users.sample,
    title:  Faker::Name.name,
    url:  'https://www.youtube.com/',
    kind: Faker::Lorem.characters(10)
   )
    post.save
end

puts "Seed finished"
 puts "#{Post.count} posts created"
 puts "#{User.count} users created"