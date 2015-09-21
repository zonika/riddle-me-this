Rails.application.routes.draw do

  root "home#index"
  post '/send', to: "text#send_text_message"
  post '/request', to: 'text#request'
  # get '/', to: "home#index"
end
