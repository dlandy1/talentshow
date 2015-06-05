User.all.each do |u|
  if Newsletter.all.collect(&:email).index(u.email)
  else
  news = Newsletter.new(
    email: u.email
    )
  news.save
end
end
puts "#{Newsletter.count} emails created"