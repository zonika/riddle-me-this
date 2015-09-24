class User < ActiveRecord::Base
  validates :phone_number, presence: true, uniqueness: true
  validates :name, presence: true

# create Twilio API variables to allow for sending of riddles to User via SMS
  def self.create_twilio_api_client
    @twilio_sid = ENV['TWILIO_ACCOUNT_SID']
    @twilio_token = ENV['TWILIO_AUTH_TOKEN']
    @twilio_phone_number = "18452131363"
    @twilio_client = Twilio::REST::Client.new @twilio_sid, @twilio_token
  end

# create & send Riddle questions to the user
  def self.create_twilio_client_question
    @twilio_client.account.messages.create({
        :from => @twilio_phone_number,
        :to => "+1" + @number_to_send_to.to_s,
        :body => @question
      })
  end

  def self.send_questions
    riddle = Riddle.all.sample
    @question = riddle.question
    create_twilio_api_client

    all.each do |user|
      @number_to_send_to = user.phone_number
      begin
        user_with_riddle = UsersRiddle.create(user_id: user.id, riddle_id: riddle.id)
        create_twilio_client_question
      rescue Twilio::REST::RequestError => error
        puts error.message
      end
    end
  end

# create & send Riddle answers to the user
  def self.create_riddle_and_client_answer(user)
    @number_to_send_to = user.phone_number
    user_riddle = UsersRiddle.where("user_id" == user.id).last
    riddle = Riddle.find(user_riddle.riddle_id)
    @answer = riddle.answer
    create_twilio_client_answer
  end

  def self.create_twilio_client_answer
    @twilio_client.account.messages.create({
        :from => @twilio_phone_number,
        :to => "+1" + @number_to_send_to.to_s,
        :body => @answer
      })
  end

  def self.send_answers
    create_twilio_api_client
    # iterate through users & check for answers. Send answer if unanswered.
    all.each do |user|
      begin
        create_riddle_and_client_answer(user) unless user.has_answered
      rescue Twilio::REST::RequestError => error
        puts error.message
      end
    end
    self.reset_answers
  end

  # user.has_answered should default to false in db at the end of each day
  def self.reset_answers
    all.each do |user|
      user.has_answered = false
    end
  end
end
