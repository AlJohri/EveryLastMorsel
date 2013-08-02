class CreatePlots < ActiveRecord::Migration
  def change
    create_table :plots do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.float :latitude
      t.float :longitude
      t.text :about

      t.timestamps
    end
  end
end