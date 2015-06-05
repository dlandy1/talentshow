class QueueController < ApplicationController
  def show
    @posts = Post.where(accepted: nil).order("created_at DESC").page(params[:page]).per(20)
  end
end
