class PlotsController < InheritedResources::Base

  layout lambda { |placeholder| params[:plot_id] || params[:id] ? "profile" : params[:user_id] ? "profile" : "application" }

  respond_to :html, :xml, :json
  belongs_to :user, :optional => true

  # CHANGE REDIRECT
  def create
    create! do |success, failure|
      success.html {
        if params[:user_id]
          user = User.find(params[:user_id])
          @plot.users << user
        end
        redirect_to polymorphic_url(@plot)
      }
    end
  end

  def index
    super do |format|
      format.json { render :json => @plots }
    end
  end  

end