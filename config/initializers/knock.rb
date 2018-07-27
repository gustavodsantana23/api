Knock.setup do |config|
  config.token_lifetime = 10.year
  config.token_signature_algorithm = 'HS256'
  config.token_secret_signature_key = -> { Rails.application.credentials.secret_key_base }
  config.not_found_exception_class_name = 'ActiveRecord::RecordNotFound'
end
