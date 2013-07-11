class Upload < ActiveRecord::Base
  attr_accessible :upload
  has_attached_file :upload
  
  has_attached_file :upload, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:original),
      "delete_url" => upload_path(self),
      "delete_type" => "DELETE" 
    }
  end

end