Rails.application.routes.draw do
  devise_for :users

  root "home#index"
  post '/send', to: "text#send_text_message"
  # get '/', to: "home#index"
end
