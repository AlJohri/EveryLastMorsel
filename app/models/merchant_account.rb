class MerchantAccount < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :phone, :street_address, :postal_code,
                  :locality, :region, :date_of_birth, :ssn, :routing_number, :account_number,
                  :tos_accepted
                  
  # associations
  belongs_to :user
  
  # validations
  validates :first_name, :last_name, :email, :street_address, :postal_code,
            :locality, :region, :date_of_birth, :tos_accepted, 
            presence: true
  
  # methods
  
  def send_to_braintree
    result = Braintree::MerchantAccount.create(
      :applicant_details => {
        :first_name => self.first_name,
        :last_name => self.last_name,
        :email => self.email,
        :phone => self.phone,
        :address => {
          :street_address => self.street_address,
          :postal_code => self.postal_code,
          :locality => self.locality,
          :region => self.region,
        },
        :date_of_birth => self.date_of_birth,
        :ssn => self.ssn,
        :routing_number => self.routing_number,
        :account_number => self.account_number
      },
      :tos_accepted => self.tos_accepted,
      :master_merchant_account_id => ENV["BRAINTREE_SANDBOX_MERCHANT_ID"],
      :id => "blue_ladders_store"
    )
  end
  
end
