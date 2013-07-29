class PlotsController < InheritedResources::Base #ApplicationController

  layout lambda { |placeholder| params[:user_id] ? "plots" : "application" }

  respond_to :html, :xml, :json
  belongs_to :user, :optional => true

end