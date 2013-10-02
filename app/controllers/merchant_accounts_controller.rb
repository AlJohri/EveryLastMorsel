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
    if @braintree_result.success?
      @merchant_account.add_merchant_ids_and_status(@braintree_result)
      if @merchant_account.save
        redirect_to @user, notice: "Merchant account successfully submitted. Account approval is now pending. You will
                                    be notified of your merchant account acceptance."
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

end
