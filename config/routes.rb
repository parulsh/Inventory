Rails.application.routes.draw do
  resources :users, except: :show
  resources :products
  
  get "/user/show", to: 'users#show'
  post '/auth/login', to: 'authentication#login'
  put '/password_change', to: 'users#change_password'
end
