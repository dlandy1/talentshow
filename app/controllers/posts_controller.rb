class PostsController < ApplicationController
   respond_to :html, :js
  def index
    @post_groups= Post.order('rank DESC').group_by{|post| [post.created_at.wday, post.created_at.to_date]}
    @sorted_groups = @post_groups.sort_by { |name, age| age.first.created_at }.reverse
  end

  def show
    @post = Post.friendly.find(params[:id])
    @user = @post.user
    @comments = @post.comments
    @comment = Comment.new
    respond_with(@post) do |format|
    end
  end

  def new
    if current_user != nil
      @post = Post.new
      respond_with(@post) do |format|
      
    end
     else
       flash[:error] = "You must sign in before posting an artist or performer."
      redirect_to new_user_session_path 
    end
  end

  def edit
     @post = Post.friendly.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
    else
    end
    respond_with(@post) do |format|
      format.html { redirect_to [@post] }
    end
  end

  def update
     @post = Post.friendly.find(params[:id])
     if @post.update_attributes(post_params)
         flash[:notice] = "Post was updated."
         redirect_to post_path(@post)
       else
         flash[:error] = "There was an error saving the post. Please try again."
         render :edit
       end
  end

  def destroy
    @post = Post.friendly.find(params[:id])
     if @post.destroy
      flash[:notice] = "#{@post.title} was deleted successfully."
      redirect_to  root_path
    else 
      flash[:error] = "There was an error deleting the post."
      redirect_to [@post]
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :kind, :url)
  end

end
