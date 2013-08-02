class Yield < ActiveRecord::Base
  attr_accessible :pick_date, :quantity, :quantity_for_sale, :quantity_unit
  attr_accessible :plot_crop_variety, :plot_crop_variety_id
  
  belongs_to :plot_crop_variety
end