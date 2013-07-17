class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  attr_accessible :user, :content, :title, :created_at, :updated_at
  acts_as_taggable

  extend FriendlyId
  friendly_id :title, use: :slugged

  include ::ActionView::Helpers::TextHelper

  validates :title, presence: true # length: { minimum: 2, maximum: 66 }
  validates :content, presence: true, length: { minimum: 10 }
  validates :user, presence: true

  def short_body
    # include ActionView::Helpers::TextHelper
    truncate(content, length: 400, separator: "\n")
  end

end