class CommentsController < ApplicationController
  def create
    @post = Post.friendly.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.new( comment_params )
    @comment.post = @post
    @new_comment = Comment.new

    if current_user
        if @comment.save
        else
          flash[:error] = "Error creating comment."
        end
      respond_with(@comment) do |format|
        format.html { redirect_to [@post] }
      end
    end
  end

  def destroy
    @post = Post.friendly.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
     if current_user
        if @comment.destroy
        else
          flash[:error] = "Comment was not deleted. Try again."
        end
      end
    respond_with(@comment) do |format|
       format.html { redirect_to [@post] }
    end
  end
end
