class CreateCrops < ActiveRecord::Migration
  def change
    create_table :crops do |t|
      t.decimal :coverage
      t.string :coverage_unit
      t.datetime :plant_date
      t.references :plot
      t.references :crop_type
      t.references :crop_variety

      t.timestamps
    end
    add_index :crops, :plot_id
    add_index :crops, :crop_type_id
    add_index :crops, :crop_variety_id
  end
end
