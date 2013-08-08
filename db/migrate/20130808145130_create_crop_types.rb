class CreateCropTypes < ActiveRecord::Migration
  def change
    create_table :crop_types do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
