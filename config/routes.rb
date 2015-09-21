Rails.application.routes.draw do

  root "home#index"
  post '/send', to: "text#send_text_message"
  get '/request', to: 'text#request'
end
