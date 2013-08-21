# require 'rails_ext/tag_helper_ext'

if Rails.env.development?
	Braintree::Configuration.environment = ENV["BRAINTREE_SANDBOX_ENVIRONMENT"].try(:to_sym) || :sandbox
	Braintree::Configuration.merchant_id = ENV["BRAINTREE_SANDBOX_MERCHANT_ID"]
	Braintree::Configuration.public_key  = ENV["BRAINTREE_SANDBOX_PUBLIC_KEY"]
	Braintree::Configuration.private_key = ENV["BRAINTREE_SANDBOX_PRIVATE_KEY"]

	BraintreeRails::Configuration.environment = ENV["BRAINTREE_SANDBOX_ENVIRONMENT"].try(:to_sym) || :sandbox
	BraintreeRails::Configuration.merchant_id = ENV["BRAINTREE_SANDBOX_MERCHANT_ID"]
	BraintreeRails::Configuration.public_key = ENV["BRAINTREE_SANDBOX_PUBLIC_KEY"]
	BraintreeRails::Configuration.private_key = ENV["BRAINTREE_SANDBOX_PRIVATE_KEY"]
	BraintreeRails::Configuration.client_side_encryption_key = ENV['BRAINTREE_SANDBOX_CLIENT_SIDE_ENCRYPTION_KEY']
else
	Braintree::Configuration.environment = ENV["BRAINTREE_ENVIRONMENT"].try(:to_sym) || :sandbox
	Braintree::Configuration.merchant_id = ENV["BRAINTREE_MERCHANT_ID"]
	Braintree::Configuration.public_key  = ENV["BRAINTREE_PUBLIC_KEY"]
	Braintree::Configuration.private_key = ENV["BRAINTREE_PRIVATE_KEY"]

	BraintreeRails::Configuration.environment = ENV["BRAINTREE_ENVIRONMENT"].try(:to_sym) || :sandbox
	BraintreeRails::Configuration.merchant_id = ENV["BRAINTREE_MERCHANT_ID"]
	BraintreeRails::Configuration.public_key = ENV["BRAINTREE_PUBLIC_KEY"]
	BraintreeRails::Configuration.private_key = ENV["BRAINTREE_PRIVATE_KEY"]
	BraintreeRails::Configuration.client_side_encryption_key = ENV['BRAINTREE_CLIENT_SIDE_ENCRYPTION_KEY']
end

BraintreeRails::Configuration.logger = Logger.new('log/braintree.log')