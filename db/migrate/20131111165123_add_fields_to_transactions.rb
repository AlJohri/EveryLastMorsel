class AddFieldsToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :cc_number, :string
    add_column :transactions, :cc_expiration_month, :string
    add_column :transactions, :cc_expiration_year, :string
    add_column :transactions, :cc_cardholder_name, :string
    add_column :transactions, :cc_cvv, :string
  end
end
