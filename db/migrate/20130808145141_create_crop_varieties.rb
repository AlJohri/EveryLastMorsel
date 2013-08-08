class CreateCropVarieties < ActiveRecord::Migration
  def change
    create_table :crop_varieties do |t|
      t.string :name
      t.string :description
      t.references :crop_type

      t.timestamps
    end
    add_index :crop_varieties, :crop_type_id
  end
end
