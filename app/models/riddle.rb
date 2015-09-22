class Riddle < ActiveRecord::Base

  def validate_riddle(answer)
    if answer.include?(self.keyword)
      "#{answer} is correct! You are simply a genius!"
    else
      "Wrong. The answer is #{self.answer}."
    end
  end

end
