class ActivitiesController < ApplicationController
  def index
  	@activities = PublicActivity::Activity.where{key =~ '%.create'}.order("created_at desc").page params[:page]
  end

end