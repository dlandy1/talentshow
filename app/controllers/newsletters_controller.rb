class NewslettersController < ApplicationController
   respond_to :html, :js
  def create
    @newsletter = Newsletter.new( news_params )
    @new_news = Newsletter.new
     if @newsletter.save
     end
  end

  private

  def news_params
    params.require(:newsletter).permit(:email)
  end
end
