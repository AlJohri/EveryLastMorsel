class Transaction < ActiveRecord::Base
  attr_accessible :user_id, :amount, :crop_yield_id, :quantity
  
  validates :amount, presence: true
  validates :crop_yield_id, presence: true
  validates :quantity, presence: true
  
  belongs_to :crop_yield
  
  def reduce_crop_yield_quantity
    crop_yield = self.crop_yield
    crop_yield.quantity_for_sale -= self.quantity
    crop_yield.save!
  end
  
  def get_amount(crop_yield)
    self.amount = crop_yield.price * self.quantity
  end
  
end
