class PlotCropVarietiesController < InheritedResources::Base

	layout lambda { |placeholder| params[:plot_id] || params[:id] ? "profile/plot-profile" : "profile/user-profile" }

  	respond_to :html, :xml, :json
  	belongs_to :plot, :optional => true

	def index
		if params[:user_id]
			@plot_crop_varieties = Array.new
			@user = User.find(params[:user_id])
			@user.plots.each do |plot|
				(@plot_crop_varieties << plot.plot_crop_varieties).flatten
			end
		end

		super
	end
  	
end