class User < ActiveRecord::Base
 validates :phone_number, presence: true, uniqueness: true, format: { with: /\d{10}/, message: "must be a number" }
 validates :name, presence: true, uniqueness: true
 after_create :send_welcome

 @@twilio_sid = ENV['TWILIO_ACCOUNT_SID']
 @@twilio_token = ENV['TWILIO_AUTH_TOKEN']
 @@twilio_phone_number = "18452131363"

  def self.twilio_client
    @twilio_client = Twilio::REST::Client.new @@twilio_sid, @@twilio_token
  end

 def self.send_questions
   self.reset_answers
   riddle = Riddle.all.sample
   @question = riddle.question

   all.each do |user|
    user_with_riddle = UsersRiddle.create(user_id: user.id, riddle_id: riddle.id)
    user.create_text(@question,user.phone_number)
   end
 end

 def self.send_answers
   twilio_client

   all.each do |user|
    unless user.has_answered
      user_riddle = UsersRiddle.where("user_id" == user.id).last
      riddle = Riddle.find(user_riddle.riddle_id)
      @answer = riddle.answer
      user.create_text("The answer is #{@answer.downcase} Better luck next time!",user.phone_number)
      user.has_answered = true
      user.save
    end
   end
 end

 def add_points
  t = Time.now.hour
  self.has_answered = true
  self.points += 100 - ((t-17)*10)
  self.save
 end

def subtract_points
  unless self.points == 0
    self.points -= 5
    self.save
  end
end


def create_text(body,number)
  begin
  User.twilio_client.account.messages.create({
    :from => @@twilio_phone_number,
    :to => "+1" + number.to_s,
    :body => body
  })
  rescue Twilio::REST::RequestError => error
     puts error.message
   end
 end

 private
 def self.reset_answers
   all.each do |user|
     user.has_answered = false
     user.save
   end
 end
 def send_welcome
   create_text("Welcome to Riddl!! You will receive a riddle once a day at 1pm EST. Guess the correct answer to win points and make your way to the top of the leaderboard! You can text STOP to this number anytime to quit the game.",phone_number)
 end
end
