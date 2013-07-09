class CreatePlots < ActiveRecord::Migration
  def change
    create_table :plots do |t|
      t.references :user
      t.string :name
      t.string :city
      t.string :state
      t.string :zip
      t.text :about

      t.timestamps
    end
    add_index :plots, :user_id
  end
end