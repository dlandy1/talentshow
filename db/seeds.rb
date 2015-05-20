# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
 # Create Users

30.times do
   post = Post.create!(
    title:  Faker::Name.name,
    url:  'https://www.youtube.com/',
    kind: Faker::Lorem.characters(10)
   )
    post.save
end

puts "Seed finished"
 puts "#{Post.count} posts created"