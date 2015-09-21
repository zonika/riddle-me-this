require 'twilio-ruby'

class TextController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  end

  # def send_text_message
  #   number_to_send_to = params[:number_to_send_to]
  #
  #   twilio_sid = ENV['TWILIO_ACCOUNT_SID']
  #   twilio_token = ENV['TWILIO_AUTH_TOKEN']
  #   twilio_phone_number = "18452131363"
  #   @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
  #
  #   @twilio_client.account.sms.messages.create(
  #     :from => "+1#{twilio_phone_number}",
  #     :to => number_to_send_to,
  #     :body => "testing"
  #   )
  # end

  def send_sms
    binding.pry
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "HAHAHAHHAA U SUCK"
    end
    render xml: twiml.to_xml
  end
end
