Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'CzttzmEC3uYdbPoErwGlew', 'Z4qaNIh0tZDodhzUkXJ0Zu5gRmhmYOyzSekIPUmI0vU'
  provider :facebook, '153390038111267', '2b96408a9726e87cb7c46cf7f1d0100a'
end

# else here for Twitter

Twitter.configure do |config|
  config.consumer_key = 'CzttzmEC3uYdbPoErwGlew'
  config.consumer_secret = 'Z4qaNIh0tZDodhzUkXJ0Zu5gRmhmYOyzSekIPUmI0vU'
end
