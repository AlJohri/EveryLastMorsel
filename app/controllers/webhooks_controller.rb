class WebhooksController < ApplicationController
  def create
    signature, payload = Braintree::WebhookTesting.sample_notification(
      Braintree::WebhookNotification::Kind::SubscriptionWentPastDue,
      rand(10000)
    )
    NotificationStore.add(Braintree::WebhookNotification.parse(signature, payload))
    redirect_to webhooks_path
  end

  def destroy_all
    NotificationStore.clear
    redirect_to webhooks_path
  end

  def handle
    notification = Braintree::WebhookNotification.parse(params[:bt_signature], params[:bt_payload])
    NotificationStore.add(notification)
    
    @merchant_account = MerchantAccount.find_by_merchant_account_id(notification.merchant_account.id)
    @merchant_account.status = notification.merchant_account.status
    if notification.kind == Braintree::WebhookNotification::Kind::SubMerchantAccountDeclined
      @merchant_account.last_notification_message = notification.message
    end
    @merchant_account.save
    
    head :ok
  end

  def index
    @notifications = NotificationStore.notifications
  end

  def verify
    render :text => Braintree::WebhookNotification.verify(params[:bt_challenge])
  end
end
