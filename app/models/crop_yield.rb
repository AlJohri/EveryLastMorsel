class CropYield < ActiveRecord::Base
  belongs_to :crop
  attr_accessible :crop_id
  attr_accessible :pick_date, :quantity, :quantity_for_sale, :quantity_unit, :price
  
  # validations
  validates :quantity, :numericality => { only_integer: true, greater_than_or_equal_to: 0 }
  
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }  
  
  scope :for_sale, ->() { where("quantity_for_sale > ?", 0) }
  
  def for_sale?
    self.quantity_for_sale > 0 ? true : false
  end
  
  def farmers
    self.crop.plot.users.pluck(:name).to_sentence
  end
end
