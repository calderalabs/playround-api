module RoundsHelper
  def round_status_message(round)
    if round.past?
      if round.full?
        t('views.rounds.helpers.past.full')
      else
        t('views.rounds.helpers.past.not_full')
      end
    else
      if round.full?
        t('views.rounds.helpers.not_past.full')
      else
        t('views.rounds.helpers.not_past.not_full')
      end
    end
  end
  
  def round_subscription_message(round)
    time_ago_in_words(round.date).capitalize + t('views.rounds.helpers.left_to_subscribe')
  end
  
  def round_confirmation_message(round)
    if round.confirmed?
      t('views.rounds.helpers.confirmed')
    elsif round.pending?
      t('views.rounds.helpers.pending')
    elsif round.rejected?
      t('views.rounds.helpers.rejected')
    elsif round.approved?
      t('views.rounds.helpers.approved')
    end
  end
end
