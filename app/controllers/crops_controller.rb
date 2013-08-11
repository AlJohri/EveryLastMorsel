class CropsController < InheritedResources::Base

  # removed params[:id]
  layout lambda { |placeholder| params[:plot_id] ? "profile" : "profile" }

  respond_to :html, :xml, :json
  belongs_to :plot, :user, :optional => true

end