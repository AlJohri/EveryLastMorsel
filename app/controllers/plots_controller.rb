class PlotsController < InheritedResources::Base

  layout lambda { |placeholder| params[:plot_id] || params[:id] ? "profile/plot-profile" : params[:user_id] ? "profile/user-profile" : "application" }

  respond_to :html, :xml, :json
  belongs_to :user, :optional => true

end