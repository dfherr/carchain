Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
  get '/imprint', to: 'home#imprint'

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
  end

  scope :ethereum do
    get '/register_car', to: 'ethereum#register_car'
  end
end
