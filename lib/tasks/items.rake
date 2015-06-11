namespace :items do

  desc "Send email"
  task send_email: :environment do
   UserMailer.news.deliver_now
  end

  desc "add email"
  task add_email: :environment do
    User.where("created_at >= ?", Time.zone.now.beginning_of_day).each do |u|
      Newletter.create(email: u.email)
    end
  end


   
end