class AddUploadtoUploads < ActiveRecord::Migration
  def up
    add_attachment :uploads, :upload
  end

  def down
    remove_attachment :uploads, :upload
  end
end
