class Post < ActiveRecord::Base
  include ::ActionView::Helpers::TextHelper
  extend FriendlyId
  attr_accessible :user, :content, :title, :created_at, :updated_at

  # Associations
  belongs_to :user
  has_many :comments

  # Third Party Addons (FriendlyID, Acts as Taggable, Make Flaggable, Acts as Follower)
  acts_as_taggable
  make_flaggable :heart
  friendly_id :title, use: :slugged
  acts_as_followable
  acts_as_follower
  # https://github.com/tcocca/acts_as_follower
  # https://github.com/cavneb/make_flaggable

  validates :title, presence: true # length: { minimum: 2, maximum: 66 }
  validates :content, presence: true, length: { minimum: 10 }
  validates :user, presence: true

  def short_body
    # include ActionView::Helpers::TextHelper
    truncate(content, length: 400, separator: "\n")
  end

end