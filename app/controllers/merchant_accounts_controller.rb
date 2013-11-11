class MerchantAccountsController < ApplicationController
  
  layout "profile", except: [:bt_webhook_notification]
  
  def bt_webhook_notification
    
    challenge = request.params["bt_challenge"]
    challenge_response = Braintree::WebhookNotification.verify(challenge)
    return [200, challenge_response]

    # @merchant_account = MerchantAccount.find_by_merchant_account_id(notification.merchant_account.id)
    # @merchant_account.status = notification.merchant_account.status
    # if notification.kind == Braintree::WebhookNotification::Kind::SubMerchantAccountDeclined
    #   @merchant_account.last_notification_message = notification.message
    # end
    # @merchant_account.save!
  end
  
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
