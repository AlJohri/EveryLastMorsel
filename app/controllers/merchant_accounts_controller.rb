class MerchantAccountsController < ApplicationController
  
  def new
    @user = User.find(params[:user_id])
    @merchant_account = @user.merchant_accounts.build
  end
  
  def create
    
  end
end
