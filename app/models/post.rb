class Post < ActiveRecord::Base
  include ::ActionView::Helpers::TextHelper
  extend FriendlyId
  attr_accessible :user, :content, :title, :created_at, :updated_at

  # Associations
  belongs_to :user
  has_many :comments

  # Third Party Addons (FriendlyID, Acts as Taggable, Make Flaggable, Acts as Follower)
  acts_as_taggable
  
  make_flaggable :dig

  friendly_id :title, use: :slugged
  acts_as_followable
  acts_as_follower
  # https://github.com/tcocca/acts_as_follower
  # https://github.com/cavneb/make_flaggable
  
  validates :title, presence: true # length: { minimum: 2, maximum: 66 }
  validates :content, presence: true, length: { minimum: 10 }
  validates :user, presence: true

  attr_accessible :picture
  
  has_attached_file :picture, 
    :default_url => "/assets/placeholder_:style.jpg", 
    styles: {
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>'
    }

  def short_body
    truncate(content, length: 400, separator: "\n")
  end

end