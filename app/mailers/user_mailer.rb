class UserMailer < ActionMailer::Base
  default from: "daniellandy1@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome')
  end

  def news
    mail(to: '', bcc: Newsletter.all.collect(&:email), subject: 'Welcome')
  end
end
