class CropYieldsController < InheritedResources::Base
  # before_filter :user_has_active_merchant_account, only: [:update]
  before_filter :correct_user, only: [:edit, :update]

  respond_to :html, :xml, :json

  belongs_to :user, :plot, :polymorphic => true
  belongs_to :crop
  
  layout "profile", except: [:marketplace]
  
  def marketplace
    @crop_yields = CropYield.for_sale.order("pick_date ASC")
  end

  def index
    super do |format|
      format.json { render :json => @yields }
    end
  end

  def create
    @crop_yield = CropYield.new(params[:crop_yield])
    @crop = @crop_yield.crop
    if @crop_yield.save
      redirect_to [@crop.plot, @crop], notice: "Crop yield has been added."
    else
      render "crops/users/show"
    end
  end
  
  def edit
    @crop_yield = CropYield.find(params[:id])
    @crop = @crop_yield.crop
  end
  
  def update
    @crop_yield = CropYield.find(params[:id])
    @crop = @crop_yield.crop
    if @crop_yield.update_attributes(params[:crop_yield])
      redirect_to user_crop_path(current_user, @crop_yield.crop), notice: 'Crop yield has been updated.'
    else
      render "crop_yields/users/edit"
    end
  end
  
  private

    def correct_user
      @crop_yield = CropYield.find(params[:id])
      redirect_to root_path unless current_user && @crop_yield.crop.plot.users.to_a.include?(current_user)
    end
  
    def user_has_active_merchant_account
      unless current_user.merchant_account && current_user.merchant_account.active?
        redirect_to new_user_merchant_account_path(current_user), notice: "Please create a merchant account."
      end
    end

end