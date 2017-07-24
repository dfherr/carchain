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
    get '/registration/end_registration', to: 'registration#end_registration'
    get '/registration/change_registration', to: 'registration#change_registration'
    get '/registration/search_for_registration/', to: 'registration#search_for_registration'
    get '/registration/search_for_owner/', to: 'registration#search_for_owner'

    post '/registration/register', to: 'registration#create_registration', as: 'create_registration'
  end

  scope :ethereum do
    get '/web3_client_version', to: 'ethereum#web3_client_version'
    get '/owner_data/:contract', to: 'ethereum#owner_data'
    get '/owner_name/:contract', to: 'ethereum#owner_name'
    get '/deploy_contract', to: 'ethereum#deploy_contract'
  end
end
