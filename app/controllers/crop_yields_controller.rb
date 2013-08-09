class CropYieldsController < InheritedResources::Base

  respond_to :html, :xml, :json

  belongs_to :user, :plot, :polymorphic => true
  belongs_to :crop

  def index
    super do |format|
      format.json { render :json => @yields }
    end
  end

  def create
	create! { polymorphic_url([parent, @crop]) }
  end

end