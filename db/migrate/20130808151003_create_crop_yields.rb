class CreateCropYields < ActiveRecord::Migration
  def change
    create_table :crop_yields do |t|
      t.decimal :quantity
      t.string :quantity_unit
      t.decimal :quantity_for_sale
      t.datetime :pick_date
      t.references :crop

      t.timestamps
    end
    add_index :crop_yields, :crop_id
  end
end
