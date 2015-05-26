class VotesController < ApplicationController
  respond_to :html, :js

  before_action :load_post_and_vote
  def vote
    if @post.already_voted?(current_user)
      @post.remove_vote!(current_user)
      respond_with(@product) do |format|
        format.html { redirect_to :back}
      end
    elsif
      @post.vote!(current_user)
      respond_with(@product) do |format|
        format.html { redirect_to :back}
      end
    else
    end
  end
   private

    def load_post_and_vote
      @post = Post.friendly.find(params[:post_id])
    end
end
