class ChangeAmountInTransactions < ActiveRecord::Migration
  def up
    change_column :transactions, :amount, :float
  end
  
  def down
    change_column :transactions, :amount, :integer
  end
end
