require 'twilio-ruby'

class TextController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  end

  def send_sms
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "HAHAHAHHAA U SUCK"
    end
    render xml: twiml.to_xml
  end
end
