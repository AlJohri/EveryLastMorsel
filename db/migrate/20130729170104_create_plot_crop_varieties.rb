class CreatePlotCropVarieties < ActiveRecord::Migration
  def change
    create_table :plot_crop_varieties do |t|
      t.datetime :plant_date
      t.decimal :coverage
      t.string :coverage_type
      t.integer :plot_id
      t.integer :crop_id
      t.integer :variety_id

      t.timestamps
    end
  end
end