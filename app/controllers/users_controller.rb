class UsersController < ApplicationController
  # before_filter :authenticate_user!

  def index
    # authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
    respond_to do |format|
      format.html { render :layout => 'application'}
      format.json { render :json => @users }
    end    
  end

  def show
    if params[:user_id]
      @user = User.find(params[:user_id])
    elsif params[:id]
      @user = User.find(params[:id])
    end
  end

  def edit

  end

  def create
    @user = User.create( params[:user] )
  end  

  def about
    if params[:user_id]
      @user = User.find(params[:user_id])
    elsif params[:id]
      @user = User.find(params[:id])
    end    
  end
  
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = current_user
    # @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

end