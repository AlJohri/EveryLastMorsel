class AddMoreFieldsToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :success, :boolean
    add_column :transactions, :status, :string
    add_column :transactions, :processor_response_code, :string
    add_column :transactions, :processor_response_text, :string
    add_column :transactions, :gateway_rejection_reason, :string
  end
end
