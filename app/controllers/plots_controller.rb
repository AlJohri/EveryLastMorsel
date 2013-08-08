class PlotsController < InheritedResources::Base

  layout lambda { |placeholder| params[:plot_id] || params[:id] ? "profile/plot" : params[:user_id] ? "profile/user" : "application" }

  respond_to :html, :xml, :json
  belongs_to :user, :optional => true

  def create
    super
    if params[:user_id]
      user = User.find(params[:user_id])
      @plot.users << user
    end
  end

  def index
    super do |format|
      format.json { render :json => @plots }
    end
  end  

end