class AddPriceToCropYield < ActiveRecord::Migration
  def change
    add_column :crop_yields, :price, :float, default: 0.0
  end
end
