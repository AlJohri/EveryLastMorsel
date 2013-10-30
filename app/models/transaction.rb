class Transaction < ActiveRecord::Base
  attr_accessible :user_id, :amount, :crop_yield_id, :quantity
  
end
