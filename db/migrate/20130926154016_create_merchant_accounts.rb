class CreateMerchantAccounts < ActiveRecord::Migration
  def change
    create_table :merchant_accounts do |t|
      t.integer :user_id, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone
      t.string :street_address, null: false
      t.string :postal_code, null: false
      t.string :locality, null: false
      t.string :region, null: false
      t.date :date_of_birth, null: false
      t.string :ssn
      t.string :routing_number
      t.string :account_number
      t.boolean :tos_accepted, null: false, default: false
      t.string :master_merchant_account_id, null: false
      t.string :merchant_account_id, null: false

      t.timestamps
    end
    add_index :merchant_accounts, :user_id
    add_index :merchant_accounts, :email
    add_index :merchant_accounts, :merchant_account_id
  end
end
