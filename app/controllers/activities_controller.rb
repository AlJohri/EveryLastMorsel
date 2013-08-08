class ActivitiesController < ApplicationController
  layout "generic"
  
  def index
  	@activities = PublicActivity::Activity.order("created_at desc")
  end
end