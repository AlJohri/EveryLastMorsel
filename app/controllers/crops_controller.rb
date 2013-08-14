class CropsController < InheritedResources::Base

  # removed params[:id]
  layout lambda { |placeholder| params[:plot_id] ? "profile" : "profile" }

  respond_to :html, :xml, :json
  belongs_to :plot, :user, :optional => true

  def create
	 create! do |success, failure|
	 	failure.html {
	 		render :action => :new and return
	 	}
	 end
  end

end