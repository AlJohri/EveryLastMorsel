class UsersController < InheritedResources::Base # ApplicationController

  # If a controller is considered a profile, eg the "user" and "plot" controllers,
  # then the id parameter should link to its own profile.
  # Otherwise, the id parameter should go to the application layout, like in the posts controller.
  layout lambda { |controller| params[:user_id] || params[:id] ? "profile" : "application" }

  has_scope :page, :default => 1

  def index
    super do |format|
      @users = @users.reorder('created_at DESC')
      format.json { render :json => @users }
      format.xml { render :xml => @users }
    end    
  end

  # https://github.com/ryanb/cancan/wiki/Inherited-Resources
  # before_filter :authenticate_user!
  #   authorize! :index, @user, :message => 'Not authorized as an administrator.'
  #   authorize! :update, @user, :message => 'Not authorized as an administrator.'
  #   authorize! :destroy, @user, :message => 'Not authorized as an administrator.'

end