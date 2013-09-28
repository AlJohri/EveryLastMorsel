class MerchantAccountsController < ApplicationController
  
  layout "profile"
  
  def index
    @user = User.find(params[:user_id])
    @merchant_account = @user.merchant_account
  end
  
  def new
    @user = User.find(params[:user_id])
    @merchant_account = @user.build_merchant_account
  end
  
  def create
    @user = User.find(params[:user_id])
    @merchant_account = @user.build_merchant_account(params[:merchant_account])
    @braintree_result = @merchant_account.send_to_braintree
    logger.debug "BRAINTREE_ID: #{Braintree::Configuration.merchant_id}"
    logger.debug "ERROR MESSAGE: #{@braintree_result.message}"
    logger.debug "ERRORS: #{@braintree_result.errors}"
    if @braintree_result.success?
      # add merchant_account_id and status
      redirect_to @user, notice: "Merchant account successfully submitted. Pending approval."
    else
      render 'new'
    end
  end

end
