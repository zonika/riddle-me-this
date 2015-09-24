class User < ActiveRecord::Base
 validates :phone_number, presence: true, uniqueness: true, format: { with: /\d{10}/, message: "must be a number" }
 validates :name, presence: true, uniqueness: true
 after_save :send_welcome

 @@twilio_sid = ENV['TWILIO_ACCOUNT_SID']
 @@twilio_token = ENV['TWILIO_AUTH_TOKEN']
 @@twilio_phone_number = "18452131363"

  def self.twilio_client
    @twilio_client = Twilio::REST::Client.new @@twilio_sid, @@twilio_token
  end

 def self.send_questions
   riddle = Riddle.all.sample
   @question = riddle.question

   all.each do |user|
     @number_to_send_to = user.phone_number
     begin
       user_with_riddle = UsersRiddle.create(user_id: user.id, riddle_id: riddle.id)
       user.create_text(@question)
     rescue Twilio::REST::RequestError => error
       puts error.message
     end
   end
 end

 def self.send_answers
   twilio_client

   all.each do |user|
     begin
       unless user.has_answered
         @number_to_send_to = user.phone_number
         user_riddle = UsersRiddle.where("user_id" == user.id).last
         riddle = Riddle.find(user_riddle.riddle_id)
         @answer = riddle.answer
         create_text(@answer)
       end
     rescue Twilio::REST::RequestError => error
       puts error.message
     end
   end
   self.reset_answers
 end

 def add_points
  points += 1
 end

 private
 def create_text(body)
   User.twilio_client.account.messages.create({
     :from => @@twilio_phone_number,
     :to => "+1" + @number_to_send_to.to_s,
     :body => body
     })
 end
 def self.reset_answers
   all.each do |user|
     user.has_answered = false
   end
 end
 def send_welcome
   @number_to_send_to = phone_number
   create_text("Welcome to Riddl!! You can text STOP to this number anytime to quit the game.")
 end
end
