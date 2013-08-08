class CropVariety < ActiveRecord::Base
  belongs_to :crop_type
  attr_accessible :crop_type_id
  attr_accessible :description, :name
end
