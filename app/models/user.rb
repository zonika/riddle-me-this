class User < ActiveRecord::Base
  validates :phone_number, presence: true, uniqueness: true
  validates :name, presence: true

  def self.send_questions
    riddle = Riddle.all.sample.question
    twilio_sid = ENV['TWILIO_ACCOUNT_SID']
    twilio_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_phone_number = "18452131363"
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    all.each do |user|
      number_to_send_to = user.phone_number
      begin
        user_with_riddle = UsersRiddle.create(user_id: user.id, riddle_id: riddle.id)
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
    # answer = @@for_today.answer
    twilio_sid = ENV['TWILIO_ACCOUNT_SID']
    twilio_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_phone_number = "18452131363"
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    all.each do |user|
      number_to_send_to = user.phone_number
      # binding.pry
      user_riddle = UsersRiddle.where("user_id" == user.id).last
      riddle = Riddle.find(user_riddle.riddle_id)
      answer = riddle.answer
      # user_riddle = UsersRiddle.where("created_at >= ?", Time.zone.now.beginning_of_day)
      # riddle = Riddle.find(user_riddle.last.riddle_id)
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
