class MerchantAccountsController < ApplicationController
  
  layout "profile"
  
  def new
    @user = User.find(params[:user_id])
    @merchant_account = @user.merchant_account || @user.build_merchant_account
  end
  
  def index
    @user = User.find(params[:user_id])
    @merchant_account = @user.merchant_account
  end
  
  def create
    @user = User.find(params[:user_id])
    @merchant_account = @user.build_merchant_account(params[:merchant_account])
    if @merchant_account.save
      @merchant_account.send_to_braintree
      redirect_to @user, notice: "Merchant account successfully created. Pending approval."
    else
      render 'new'
    end
  end
end
