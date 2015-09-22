class Riddle < ActiveRecord::Base

  def validate_riddle(answer)
    if answer.include?(keyword)
      "#{answer} is correct! You are simply a genius!"
    else
      "Try again."
    end
  end

end
