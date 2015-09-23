class Riddle < ActiveRecord::Base
  @@disses = ['HAHAHAHAHAHAHAHAH. no.', 'HEY that\'s right!!!! lol jk.', 'NOPE.', 'You are simply the worst at this.', 'We are no longer friends.', 'Really?????', 'Close, but no cigar.', 'I remember my first riddle...', 'Silly human, no cake for you!','LOL, nah.']
  def validate_riddle(answer,user)
    if answer.include?(self.keyword)
      user.has_answered = true
      user.save
      "#{answer} is correct! You are simply a genius!"
    else
      @@disses.sample + " Try again."
    end
  end
end
