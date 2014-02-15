class User::TwitterAccount < User::LoginAccount
  def assign_account_info(auth_hash)
    self.remote_account_id = auth_hash['uid']
    self.info = auth_hash['info']
    self.name = auth_hash['info']['name']
    self.email = auth_hash['info']['email']
    self.access_token = auth_hash['credentials']['token']
    self.access_token_secret = auth_hash['credentials']['secret']
    self.refresh_token = auth_hash['credentials']['refresh_token']
    self.expires_at = auth_hash['credentials']['expires_at']
  end
end
