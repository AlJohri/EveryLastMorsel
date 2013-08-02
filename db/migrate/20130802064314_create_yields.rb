class CreateYields < ActiveRecord::Migration
  def change
    create_table :yields do |t|
      t.datetime :pick_date
      t.decimal :quantity
      t.string :quantity_unit
      t.decimal :quantity_for_sale
      t.belongs_to :plot_crop_variety

      t.timestamps
    end
  end
end
