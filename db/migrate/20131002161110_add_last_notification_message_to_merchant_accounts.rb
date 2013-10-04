class AddLastNotificationMessageToMerchantAccounts < ActiveRecord::Migration
  def change
    add_column :merchant_accounts, :last_notification_message, :string
  end
end
