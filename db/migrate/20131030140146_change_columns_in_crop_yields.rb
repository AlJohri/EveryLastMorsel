class ChangeColumnsInCropYields < ActiveRecord::Migration
  def up
    change_column :crop_yields, :quantity, :integer
    change_column :crop_yields, :quantity_for_sale, :integer, default: 0
  end
  def down
    change_column :crop_yields, :quantity, :decimal
    change_column :crop_yields, :quantity_for_sale, :decimal, default: 0
  end
end
