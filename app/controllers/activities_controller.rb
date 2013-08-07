class ActivitiesController < ApplicationController
  layout "generic"
  
  def index
  	@activities = PublicActivity::Activity.order("created_at desc")
  	#@activities = PublicActivity::Activity.all
  end
end