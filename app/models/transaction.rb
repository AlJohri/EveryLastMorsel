class Transaction < ActiveRecord::Base
  attr_accessible :user_id, :amount, :crop_yield_id, :quantity
  
  validates :amount, presence: true
  validates :crop_yield_id, presence: true
  validates :quantity, presence: true
  
end
