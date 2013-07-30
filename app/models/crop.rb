class Crop < ActiveRecord::Base
  attr_accessible :description, :name
  attr_accessible :variety_ids
  has_many :varieties
end