class CropType < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :crop_varieties
end