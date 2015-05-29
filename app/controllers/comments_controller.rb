class CommentsController < ApplicationController
    respond_to :html, :js

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
    end
    respond_with(@comment) do |format|
       format.html { redirect_to [@post] }
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @post = @comment.post
  end

  def reply
    @comment = Comment.find(params[:comment_id])
    @new_comment = @comment.subcomments.new
    @post= Post.friendly.find(params[:post_id])
     respond_with(@comment) do |format|
       format.html { redirect_to [@post] }
    end
  end

   def cancel
    @comment = Comment.find(params[:comment_id])
    @post= Post.friendly.find(params[:post_id])
     respond_with(@comment) do |format|
       format.html { redirect_to [@post] }
    end
  end

  def update
         @comment = Comment.find(params[:id])
         @new_comment = @comment
         @post = @comment.post
          if @comment.update_attributes(comment_params)
            redirect_to [@post]
          else
           render :action => "edit" 
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

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

end
