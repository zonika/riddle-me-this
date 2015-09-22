class User < ActiveRecord::Base

  def self.send_texts
    riddle = Riddle.all.sample.question
    all.each do |user|
      number_to_send_to = user.phone_number

      twilio_sid = ENV['TWILIO_ACCOUNT_SID']
      twilio_token = ENV['TWILIO_AUTH_TOKEN']
      twilio_phone_number = "18452131363"
      @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
      begin
        message = @twilio_client.account.messages.create(
          :body => riddle,
          :to => "+1"+number_to_send_to.to_s,
          :from => twilio_phone_number)
      rescue Twilio::REST::RequestError
      end
    end
  end
end
