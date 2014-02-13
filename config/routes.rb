Rails4DeviseSocialLogins::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # root 'welcome#index'
end
