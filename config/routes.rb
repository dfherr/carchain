Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :ethereum do
    get '/user/:id', to: 'ethereum#user', as: :user
    get '/register_car', to: 'ethereum#register_car'
  end
end
