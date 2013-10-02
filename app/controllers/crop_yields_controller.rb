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
  
  def update
    @crop_yield = CropYield.find(params[:id])
    if @crop_yield.update_attributes(params[:crop_yield])
      redirect_to user_crop_path(current_user, @crop_yield.crop), notice: 'Crop yield is now for sale.'
    else
      render "crops/partials/show"
    end
  end

end