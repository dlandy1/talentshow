class UsersController < ApplicationController
   # POST /users
  # POST /users.json
  before_action :set_user, only: [:show, :edit, :update, :destroy, :finish_signup]

  # GET /users/:id.:format
  def show
    # authorize! :read, @user
    @user = User.friendly.find(params[:id])
    @posts = @user.posts
  end

  # GET /users/:id/edit
  def edit
    # authorize! :update, @user
    @user = User.friendly.find(params[:id])
  end

  # PATCH/PUT /users/:id.:format
  def update
    # authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    # authorize! :update, @user 
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        @user.remake_slug
        @user.skip_reconfirmation! if @user.respond_to?(:skip_confirmation)
        sign_in(@user, :bypass => true)
        UserMailer.welcome_email(@user).deliver
        redirect_to root_url
      else
        @show_errors = true
        flash[:error] = "Put in your email or diffrent email"
      end
    end
  end

  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
  
  private
    def set_user
      @user = User.friendly.find(params[:id])
    end

    def user_params
      accessible = [ :name, :email, :image ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end

end
