class CreateVarieties < ActiveRecord::Migration
  def change
    create_table :varieties do |t|
      t.string :name
      t.string :description
      t.belongs_to :crop

      t.timestamps
    end
  end
end
