class Account < ActiveRecord::Base
  validates_presence_of :name, :provider, :uid, :oauth_token, :oauth_token_secret
  
  def self.create_with_omniauth(auth)
    create! do |account|
      auth = auth.to_hash
      puts auth.inspect
      account.provider = auth["provider"]
      account.uid = auth["uid"]
      account.name = auth["info"]["name"]
      account.nickname = auth["info"]["nickname"]
      account.oauth_token = auth["credentials"]["token"]
      account.oauth_token_secret = auth["credentials"]["secret"]
    end
  end
end
