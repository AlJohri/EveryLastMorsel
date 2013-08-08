class Plot < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode
  
  attr_accessible :about, :city, :name, :state, :zip
  attr_accessible :address1, :address2
  attr_accessible :latitude, :longitude

  acts_as_followable

  has_and_belongs_to_many :users
  accepts_nested_attributes_for :users, :allow_destroy => true
  
  has_many :crops
  has_many :crop_types, :through => :crops
  has_many :crop_varieties, :through => :crops
  
  attr_accessible :avatar
  attr_reader :avatar_remote_url

  has_attached_file :avatar, 
    :default_url => "/assets/placeholder_:style.jpg", 
    :styles => {
      thumb: '100x100#',
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

  def address
    [address1, address2, city, state].compact.join(', ')
  end

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
  
end