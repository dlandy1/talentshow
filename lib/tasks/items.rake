namespace :items do

  desc "Send email"
  task send_email: :environment do
   UserMailer.news.deliver
  end
   
end