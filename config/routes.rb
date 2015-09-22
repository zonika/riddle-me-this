Rails.application.routes.draw do
  root 'users#index'
  resources :users, :only => [:index, :create, :show]

  post '/response', to: 'text#send_sms'
end
