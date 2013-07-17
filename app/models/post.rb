class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user, :content, :title, :created_at, :updated_at

end
