Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
  get '/imprint', to: 'home#imprint'

  put '/change_locale/:locale', to: 'application#change_locale', as: 'change_locale'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  namespace :users do
    get '/roles', to: 'roles#index'
    get '/roles/manage/:id', to: 'roles#manage', as: 'roles_manage'
    post '/roles/add/:id', to: 'roles#add', as: 'roles_add'
    delete '/roles/manage/:id/:role_id', to: 'roles#destroy', as: 'roles_destroy'
  end

  namespace :car do
    get '/registration', to: 'registration#index'
    get '/registration/register', to: 'registration#register'
    get '/registration/details/:id', to: 'registration#details', as: 'registration_details'
    get '/registration/end_registration', to: 'registration#end_registration'
    post '/registration/register', to: 'registration#create_registration', as: 'create_registration'

    get '/official', to: 'official#index'
    get '/official/accept_registration/:id', to: 'official#accept_registration', as: 'accept_registration'

    get '/insurance/search_for_registration', to: 'insurance#search_for_registration'
    get '/police/search_for_owner', to: 'police#search_for_owner'
  end

  get '/parity/web3_client_version', to: 'parity#web3_client_version'
  get '/parity/generate_signer_token', to: 'parity#generate_signer_token'
  get '/parity/owner_data/:contract', to: 'parity#owner_data'
  get '/parity/owner_name/:contract', to: 'parity#owner_name'
  get '/parity/deploy_contract', to: 'parity#deploy_contract'
end
