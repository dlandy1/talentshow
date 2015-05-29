class VotesController < ApplicationController
  respond_to :html, :js

  before_action :load_post_and_vote

  def vote
    if current_user && @post.already_voted?(current_user)
      @post.remove_vote!(current_user)
      respond_with(@voters) do |format|
        format.html { redirect_to :back}
      end
    else current_user
      @post.vote!(current_user)
      respond_with(@voters) do |format|
        format.html { redirect_to :back}
      end
    end
  end

   private

    def load_post_and_vote
      @post = Post.friendly.find(params[:post_id])
      @voters = Kaminari.paginate_array(@post.voters).page(params[:page]).per(20)
    end
end
