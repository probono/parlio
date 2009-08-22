# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_parlio_session',
  :secret      => '9d9c5c13966b197e94c2cb9671856ae05be691ba2ccd6f2e094e2814639355e32b7e624eeb3f92c3be05dc0ab38370a3840040086c22f40ed6c8b2319fd10197'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
