class SendingJob < Struct.new(:msg)
  def perform
    Twitter.configure do |config|
      config.oauth_token = @account.oauth_token
      config.oauth_token_secret = @account.oauth_token_secret
    end
    Twitter::Client.new.update(msg)
  end  
end
