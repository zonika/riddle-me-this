Rails.application.routes.draw do

  post '/send', to: "text#send_text_message"
  post '/', to: 'text#send_sms'
end
