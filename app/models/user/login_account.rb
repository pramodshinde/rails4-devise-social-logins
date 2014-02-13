class User::LoginAccount
  include Mongoid::Document
  field :info, type: Hash
  field :remote_account_id, type: String
  field :access_token, type: String
  field :access_token_secret, type: String
  field :name, type: String
  field :email, type: String
  field :login, type: String
  field :user_id, type: Integer
  field :type, type: String
  field :refresh_token, type: String
  field :string, type: String
  field :expires_at, type: String
  field :string, type: String
end
