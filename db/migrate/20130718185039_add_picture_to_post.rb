class AddPictureToPost < ActiveRecord::Migration
  def up
    add_attachment :posts, :picture
  end

  def down
    remove_attachment :posts, :picture
  end
end
