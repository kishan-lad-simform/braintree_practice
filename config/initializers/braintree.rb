Braintree::Configuration.environment = :sandbox
Braintree::Configuration.logger = Logger.new('log/braintree.log')
Braintree::Configuration.merchant_id = ENV['MERCHANT_ID']
Braintree::Configuration.public_key = ENV['PUBLIC_ID']
Braintree::Configuration.private_key = ENV['PRIVATE_ID']