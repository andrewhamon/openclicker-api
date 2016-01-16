Rails.application.routes.draw do
  post 'register', to: 'users#register'
  post 'login', to: 'users#login'
  get  'user', to: 'users#show'


  post 'courses', to: 'courses#create'
  post 'courses/:access_code/enroll', to: 'courses#enroll'
  get  'courses/:access_code', to: 'courses#show'


  get 'courses/:access_code/poll', to: 'polls#show_current'
  get 'courses/:access_code/polls', to: 'polls#index'
  get 'courses/:access_code/polls/:id', to: 'polls#show'
  post 'courses/:access_code/poll/start', to: 'polls#start'
  post 'courses/:access_code/poll/stop', to: 'polls#stop'
  post 'courses/:access_code/poll', to: 'polls#create'
  post 'courses/:access_code/polls', to: 'polls#create'
end
