module RoundsHelper
  def round_status_message(round)
    if round.past?
      if round.confirmed
        "This round has already taken place"
      else
        "This round never took place"
      end
    elsif round.past_deadline?
      if round.confirmed
        "This round has been confirmed"
      else
        "This round is not confirmed yet"
      end
    else
      if round.full?
        "This round is full!"
      else
        "You can still subscribe to this round"
      end
    end
  end
  
  def round_subscription_message(round)
    time_ago_in_words(round.deadline).capitalize + ' left to subscribe!'
  end
  
  def round_confirmation_message(round)
    if round.confirmable? 
      'You can confirm now!'
    else
      'You can confirm in ' + time_ago_in_words(round.deadline)
    end
  end
end
