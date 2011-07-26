module RoundsHelper
  def round_status_message(round)
    if round.past?
      if round.full?
        "This round has already taken place"
      else
        "This round never took place"
      end
    else
      if round.full?
        "This round is full!"
      else
        "This round is not full yet"
      end
    end
  end
  
  def round_subscription_message(round)
    time_ago_in_words(round.date).capitalize + ' left to subscribe!'
  end
  
  def round_confirmation_message(round)
    if round.confirmed
      "This round has been confirmed"
    else
      "This round is not confirmed yet"
    end
  end
end
