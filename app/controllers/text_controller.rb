require 'twilio-ruby'

class TextController < ApplicationController
  def index
  end

  def send_text_message
    number_to_send_to = params[:number_to_send_to]

    twilio_sid = Rails.application.secrets.account_sid
    twilio_token = Rails.application.secrets.auth_token
    twilio_phone_number = "18452131363"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => "testing"
    )

  end
end
