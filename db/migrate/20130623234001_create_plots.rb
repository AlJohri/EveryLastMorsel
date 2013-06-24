class CreatePlots < ActiveRecord::Migration
  def change
    create_table :plots do |t|
      t.integer :user_id
      t.integer :admin_id
      t.string :name
      t.string :type
      t.string :city
      t.string :state
      t.string :zip
      t.string :visibility
      t.text :description

      t.timestamps
    end
  end
end
