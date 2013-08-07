class PlotCropVarietiesController < InheritedResources::Base

  # removed params[:id]
  layout lambda { |placeholder| params[:plot_id] ? "profile/plot-profile" : "profile/user-profile" }

  respond_to :html, :xml, :json
  belongs_to :plot, :user, :optional => true

  #Roneesh
  def create

    @plot_crop_variety.crop_id = Crop.find_by_name(:crop_name)    
    super

    if params[:user_id]
      user = User.find(params[:user_id])
      @plot.users << user
    end
  end

end