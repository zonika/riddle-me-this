class TextController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end

  def send_sms
    user = User.find_by(phone_number: params["From"].gsub("+1","").to_i)
    ans = params["Body"]
    user_riddle = UsersRiddle.where("created_at >= ?", Time.zone.now.beginning_of_day)
    riddle = Riddle.find(user_riddle.first.riddle_id)
    validated_riddle = riddle.validate_riddle(ans)
    # binding.pry
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message validated_riddle
    end
    render xml: twiml.to_xml
  end
end
