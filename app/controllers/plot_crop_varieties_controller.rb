class PlotCropVarietiesController < InheritedResources::Base
	layout lambda { |placeholder| params[:plot_id] || params[:id] ? "profile/plot-profile" : "profile/user-profile" }

  	respond_to :html, :xml, :json
  	belongs_to :plot, :optional => true
  	
end