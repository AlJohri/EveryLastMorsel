class ChangeQuantityForSaleToDefault < ActiveRecord::Migration
  def up
    change_column :crop_yields, :quantity_for_sale, :decimal, default: 0
  end
  
  def down
    change_column :crop_yields, :quantity_for_sale, :decimal
  end
end
