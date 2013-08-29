class Post < ActiveRecord::Base
  include ::ActionView::Helpers::TextHelper
  belongs_to :user
  
  attr_accessible :content, :title, :created_at, :updated_at
  attr_accessible :user, :user_id
  attr_accessible :tag_list
  
  # has_many :comments

  extend FriendlyId
  friendly_id :title, use: :slugged
  acts_as_taggable
  make_flaggable :dig
  acts_as_commentable
  
  validates :title, presence: true    # length: { minimum: 2, maximum: 66 }
  validates :content, presence: true  # length: { minimum: 10 }

  attr_accessible :picture
  # ActionController::Base.helpers.image_path("/default_avatar.png")
  has_attached_file :picture, 
    :default_url =>  ActionController::Base.helpers.asset_path('placeholder_:style.jpg'), 
    styles: {
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>'
    }

  def short_body
    truncate(content, length: 400, :omission => '') #separator: "\n"
  end

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
end
