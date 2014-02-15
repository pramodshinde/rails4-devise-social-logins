class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    unless auth_hash && auth_hash['uid']
      flash[:notice] = "Could not authorize you from Facebook"
      redirect_to(root_path) and return
    end 
    determine_oauth_class_and_process(auth_hash)
  end 

  def google_oauth2
    unless auth_hash && auth_hash['uid']
      flash[:notice] = "Could not authorize you from Google"
      redirect_to(root_path) and return
    end 
    determine_oauth_class_and_process(auth_hash)
  end

  
  def linkedin
    unless auth_hash && auth_hash['uid']
      flash[:notice] = "Could not authorize you from LinkendIn"
      redirect_to(root_path) and return
    end 
    determine_oauth_class_and_process(auth_hash)
  end 

 
  def twitter
    unless auth_hash && auth_hash['uid']
      flash[:notice] = "Could not authorize you from Twitter"
      redirect_to(root_path) and return
    end 
    determine_oauth_class_and_process(auth_hash)
  end 

  private

  def determine_oauth_class_and_process(auth_hash)
    account_clazz = get_oauth_provider_class(auth_hash['provider'])
    Rails.logger.error '============Auth Hash'
    Rails.logger.error auth_hash
    account = account_clazz.where(:remote_account_id => auth_hash['uid'].to_s ).first
    account = check_account_exist_or_create(account, auth_hash)
  end
  
  def check_account_exist_or_create(account, auth_hash)
    if account.present?
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", :kind => "#{auth_hash['provider']}")
      sign_in_and_redirect(account.user, :event => :authentication)
    else
      account_clazz = get_oauth_provider_class(auth_hash['provider'])
      account = create_oauth_account(account_clazz, auth_hash)
    end
    account
  end

  def create_oauth_account(account_clazz, auth_hash)
    account = account_clazz.build_from_auth_hash auth_hash
    if current_user.nil?
      add_user_and_login_account(account)
    else
      current_user.login_accounts << [account]
      redirect_to root_url
    end
    account
  end

  def add_user_and_login_account(account)
    user = User.where(email: account.email).first_or_create(:password => SecureRandom.hex)
    user.login_accounts << [account]
    flash[:notice] = I18n.t("devise.omniauth_callbacks.success", :kind => "#{auth_hash['provider']}")
    sign_in_and_redirect(account.user, :event => :authentication)
  end

  def get_oauth_provider_class(provider)
    case provider
    when 'twitter' then
      User::TwitterAccount
    when 'facebook' then
      User::FacebookAccount
    when 'linkedin' then
      User::LinkedInAccount
    when 'google_oauth2' then
      User::GoogleAccount
    end
  end

  def auth_hash
    @auth_hash ||= env["omniauth.auth"]
  end
end
