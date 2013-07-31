class CreateVarieties < ActiveRecord::Migration
  def change
    create_table :varieties do |t|
      t.string :name
      t.string :description
      t.belongs_to :crop

      t.timestamps
    end
	add_index :varieties, :crop_id
  end
end
