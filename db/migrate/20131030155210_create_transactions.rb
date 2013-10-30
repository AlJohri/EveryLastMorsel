class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :amount
      t.integer :crop_yield_id
      t.integer :quantity

      t.timestamps
    end
    add_index :transactions, :user_id
    add_index :transactions, :crop_yield_id
  end
end
