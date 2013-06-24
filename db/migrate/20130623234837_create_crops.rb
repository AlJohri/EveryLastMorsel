class CreateCrops < ActiveRecord::Migration
  def change
    create_table :crops do |t|
      t.integer :plot_id
      t.string :plant
      t.string :type
      t.integer :coverage_number
      t.string :coverage_unit
      t.datetime :date_planted
      t.string :starting_type
      t.text :description
      t.integer :yield_number
      t.string :yield_unit
      t.datetime :date_picked
      t.integer :quantity_number
      t.string :quantity_type
      t.decimal :price

      t.timestamps
    end
  end
end
