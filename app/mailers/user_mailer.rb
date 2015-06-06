class UserMailer < ActionMailer::Base
  default from: "contact@talentshow.io"

  def news
    @posts = Post.where(:accepted => true).where("created_at >= ?", Time.zone.now.beginning_of_day).order('rank DESC').first(3)
    mail(to: '', bcc: Newsletter.all.collect(&:email), subject: 'Top Performers of the day')

  end
end
