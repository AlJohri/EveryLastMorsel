class PlotsController < InheritedResources::Base

  layout lambda { |placeholder| params[:plot_id] || params[:id] ? "profile" : params[:user_id] ? "profile" : "application" }

  respond_to :html, :xml, :json
  belongs_to :user, :optional => true

  def create
    create! do |success, failure| success.html { redirect_to polymorphic_url(@plot) } end
  end

  def update
    update! do |success, failure| success.html { redirect_to polymorphic_url(@plot) } end
  end

  def index
    super do |format| format.json { render :json => @plots } end
  end  

end