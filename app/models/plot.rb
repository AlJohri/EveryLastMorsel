class Plot < ActiveRecord::Base
  attr_accessible :user, :user_id
  
  attr_accessible :about, :city, :name, :state, :zip
  attr_accessible :plot_crop_variety_ids
  acts_as_followable

  belongs_to :user
  has_many :plot_crop_varieties
  has_many :crops, :through => :plot_crop_varieties
  has_many :varieties, :through => :plot_crop_varieties
  
  attr_accessible :avatar
  attr_reader :avatar_remote_url

  has_attached_file :avatar, 
    :default_url => "/assets/placeholder_:style.jpg", 
    :styles => {
      thumb: '100x100',
      square: '200x200#',
      medium: '300x300#'
    }
  
  def avatar_remote_url(url_value, file_name)
    if url_value != nil
      self.avatar = uri = URI.parse(URI.encode(url_value.strip))
      self.avatar_file_name = file_name
      # self.avatar_content_type == "image/png"
      @avatar_remote_url = url_value
    end
  end  
end