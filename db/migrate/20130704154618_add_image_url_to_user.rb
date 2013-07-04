class AddImageUrlToUser < ActiveRecord::Migration
  def change
    add_column :users, :image, :string
    add_column :users, :url, :string
  end
end
