class UserMailer < ActionMailer::Base
  default from: "daniellandy1@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome')
  end

  def news
    @posts = Post.where(:accepted => true).where("created_at >= ?", Time.zone.now.beginning_of_day).order('rank DESC')
    mail(to: '', bcc: Newsletter.all.collect(&:email), subject: 'Top Performers of the day')

  end
end
