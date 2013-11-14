class Transaction < ActiveRecord::Base
  attr_accessible :user_id, :amount, :crop_yield_id, :quantity, :cc_cardholder_name,
                  :cc_number, :cc_cvv, :cc_expiration_month, :cc_expiration_year
  
  validates :amount, presence: true
  validates :crop_yield_id, presence: true
  validates :quantity, presence: true
  
  belongs_to :crop_yield
  belongs_to :user
  
  # validations
  # validates :quantity, :numericality => { only_integer: true, greater_than_or_equal_to: 0 }
  
  def reduce_crop_yield_quantity
    crop_yield = self.crop_yield
    crop_yield.quantity_for_sale -= self.quantity
    crop_yield.save!
  end
  
  def get_amount(crop_yield)
    if self.quantity
      self.amount = crop_yield.price * self.quantity
    else
      self.amount = 0
    end
  end
  
  def quantity_is_less_than?(crop_yield)
    if self.quantity && self.quantity < crop_yield.quantity_for_sale
      true
    else
      false
    end
  end
  
  def send_to_braintree(crop_yield)
    result = Braintree::Transaction.sale(
      :amount => self.amount.to_s,
      :merchant_account_id => crop_yield.user.merchant_account.merchant_account_id,
      :credit_card => {
        :number => self.cc_number,
        :expiration_month => self.cc_expiration_month,
        :expiration_year => self.cc_expiration_year,
        :cvv => self.cc_cvv
      },
      :service_fee_amount => "0.00"
    )
    self.success = result.success?
    if result.transaction
      self.status = result.transaction.status
      self.processor_response_code = result.transaction.processor_response_code if result.transaction.processor_response_code
      self.processor_response_text = result.transaction.processor_response_text if result.transaction.processor_response_text
      self.gateway_rejection_reason = result.transaction.gateway_rejection_reason if result.transaction.gateway_rejection_reason
    end
    self.save
    result
  end
  
end
