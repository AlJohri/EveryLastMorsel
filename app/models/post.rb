class Post < ActiveRecord::Base
  include ::ActionView::Helpers::TextHelper
  extend FriendlyId
  belongs_to :user
  

  attr_accessible :content, :title, :created_at, :updated_at
  attr_accessible :user, :user_id
  
  # has_many :comments

  acts_as_taggable
  make_flaggable :dig
  acts_as_commentable
  friendly_id :title, use: :slugged
  
  validates :title, presence: true # length: { minimum: 2, maximum: 66 }
  validates :content, presence: true, length: { minimum: 10 }
  # validates :user_id, presence: true

  attr_accessible :picture
  
  has_attached_file :picture, 
    :default_url => "/assets/placeholder_:style.jpg", 
    styles: {
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>'
    }

  def short_body
    truncate(content, length: 400, :omission => '') #separator: "\n"
  end

end
