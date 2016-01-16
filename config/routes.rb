Rails.application.routes.draw do
  post 'register', to: 'users#register'
  post 'login', to: 'users#login'
end
