class RoundMailer < ActionMailer::Base
  default :from => "info@playround.com"
  
  def round_confirmation_email(round)
    @round = round
    
    @round.subscribers.each do |user|
      @user = user
      mail(:to => @user.email,
           :subject => "Round confirmation")
    end
  end
end
