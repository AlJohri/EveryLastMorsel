class CropYield < ActiveRecord::Base
  belongs_to :crop
  attr_accessible :crop_id
  attr_accessible :pick_date, :quantity, :quantity_for_sale, :quantity_unit

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }  
  
end
