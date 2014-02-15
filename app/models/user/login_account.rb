class User::LoginAccount
  include Mongoid::Document

  belongs_to :user 
  
  field :info, type: Hash
  field :remote_account_id, type: String
  field :access_token, type: String
  field :access_token_secret, type: String
  field :name, type: String
  field :email, type: String
  field :refresh_token, type: String
  field :expires_at, type: String

  def self.build_from_auth_hash(auth_hash)
    account = self.new
    account.assign_account_info(auth_hash)
    account
  end 
end
