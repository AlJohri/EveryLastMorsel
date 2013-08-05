class PlotCropVarietiesController < InheritedResources::Base

  # removed params[:id]
  layout lambda { |placeholder| params[:plot_id] ? "profile/plot-profile" : "profile/user-profile" }

    respond_to :html, :xml, :json
    belongs_to :plot, :user, :optional => true

end