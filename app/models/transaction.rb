class Transaction < ActiveRecord::Base
  attr_accessible :user_id, :amount, :crop_yield_id, :quantity
  
  validates :amount, presence: true
  validates :crop_yield_id, presence: true
  validates :quantity, presence: true
  
  belongs_to :crop_yield
  belongs_to :user
  
  # validations
  validates :quantity, :numericality => { only_integer: true, greater_than_or_equal_to: 0 }
  
  def reduce_crop_yield_quantity
    crop_yield = self.crop_yield
    crop_yield.quantity_for_sale -= self.quantity
    crop_yield.save!
  end
  
  def get_amount(crop_yield)
    self.amount = crop_yield.price * self.quantity
  end
  
  def quantity_is_less_than?(crop_yield)
    if self.quantity < crop_yield.quantity
      true
    else
      false
    end
  end
  
end
