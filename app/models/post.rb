class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :title, :gallery_images
end
