class AddAvatarToPlot < ActiveRecord::Migration
  def up
    add_attachment :plots, :avatar
  end

  def down
    remove_attachment :plots, :avatar
  end
end