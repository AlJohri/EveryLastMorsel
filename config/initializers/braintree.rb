if Rails.env.development?
	Braintree::Configuration.environment = ENV["BRAINTREE_SANDBOX_ENVIRONMENT"].to_sym
	Braintree::Configuration.merchant_id = ENV["BRAINTREE_SANDBOX_MERCHANT_ID"]
	Braintree::Configuration.public_key  = ENV["BRAINTREE_SANDBOX_PUBLIC_KEY"]
	Braintree::Configuration.private_key = ENV["BRAINTREE_SANDBOX_PRIVATE_KEY"]
else
	Braintree::Configuration.environment = ENV["BRAINTREE_ENVIRONMENT"].to_sym
	Braintree::Configuration.merchant_id = ENV["BRAINTREE_MERCHANT_ID"]
	Braintree::Configuration.public_key  = ENV["BRAINTREE_PUBLIC_KEY"]
	Braintree::Configuration.private_key = ENV["BRAINTREE_PRIVATE_KEY"]
end