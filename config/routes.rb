Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "home#index"

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  namespace :users do
    get '/roles', to: 'roles#index'
    get '/roles/manage/:id', to: 'roles#manage', as: "roles_manage"
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
