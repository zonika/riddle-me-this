class User < ActiveRecord::Base
  validates :phone_number, presence: true, uniqueness: true
  validates :name, presence: true

  def self.send_questions
    @@for_today = Riddle.all.sample
    riddle = @@for_today.question
    twilio_sid = ENV['TWILIO_ACCOUNT_SID']
    twilio_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_phone_number = "18452131363"
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    all.each do |user|
      number_to_send_to = user.phone_number
      begin
        user_with_riddle = UsersRiddle.create(user_id: user.id, riddle_id: @@for_today.id)
        @twilio_client.account.messages.create({
          :from => twilio_phone_number,
          :to => "+1" + number_to_send_to.to_s,
          :body => riddle
          })
      rescue Twilio::REST::RequestError => error
        puts error.message
      end
    end
  end

  def self.send_answers
    answer = @@for_today.answer
    twilio_sid = ENV['TWILIO_ACCOUNT_SID']
    twilio_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_phone_number = "18452131363"
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    all.each do |user|
      number_to_send_to = user.phone_number
      begin
        unless user.has_answered
          @twilio_client.account.messages.create({
            :from => twilio_phone_number,
            :to => "+1" + number_to_send_to.to_s,
            :body => answer
            })
        end
      rescue Twilio::REST::RequestError => error
        puts error.message
      end
    end
    self.reset_answers
  end

  def self.reset_answers
    all.each do |user|
      user.has_answered = false
    end
  end
end
