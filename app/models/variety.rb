class Variety < ActiveRecord::Base
  attr_accessible :description, :name
  attr_accessible :crop_id
  belongs_to :crop
end