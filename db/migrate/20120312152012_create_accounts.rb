class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.string :provider
      t.integer :uid
      t.string :nickname
      t.string :oauth_token
      t.string :oauth_token_secret
      
      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
