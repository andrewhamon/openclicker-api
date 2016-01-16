Rails.application.routes.draw do
  post 'register', to: 'users#register'
  post 'login', to: 'users#login'
  get  'user', to: 'users#show'

  post 'courses', to: 'courses#create'
  post 'courses/:access_code/enroll', to: 'courses#enroll'
  get  'courses/:access_code', to: 'courses#show'
end
