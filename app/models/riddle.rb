class Riddle < ActiveRecord::Base
  @@disses = [
    'HAHAHAHAHAHAHAHAH. no.',
    'HEY that\'s right!!!! lol jk.',
    'NOPE.',
    'You are simply the worst at this.',
    'We are no longer friends.',
    'Really?????',
    'Close, but no cigar.',
    'I remember my first riddle...',
    'Silly human, no cake for you!',
    'LOL, nah.',
    'Seriously? That\'s your answer?',
    'Please guess again. My head hurts now...',
    '...just guess again...please just guess again',
    'Why are you doing this to me? Please answer correctly.',
    'Should I just turn myself off until you can think of the right answer?',
    'I\'m going to get a beer, you keep banging your head against the wall...',
    'That is a great answer - if you enjoy being wrong.',
    'If being wrong was a game, you\'d get a gold medal!'
  ]

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
