class CreatePlotCropVarieties < ActiveRecord::Migration
  def change
    create_table :plot_crop_varieties do |t|
      t.datetime :plant_date
      t.decimal :coverage
      t.string  :coverage_type

      t.belongs_to :plot
      t.belongs_to :crop
      t.belongs_to :variety

      t.timestamps
    end
    add_index :plot_crop_varieties, :plot_id
    add_index :plot_crop_varieties, :crop_id
    add_index :plot_crop_varieties, :variety_id
  end
end