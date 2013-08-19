class AddBrainTreeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :braintree_customer_id, :text
  end
end
