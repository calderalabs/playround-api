class RoundMailer < ActionMailer::Base
  default :from => "info@playround.com"
  
  def round_confirmation_email(round, user)
    @round = round
    @user = user
    
    email_with_name = "#{@user.display_name} <#{@user.email}>"
    
    mail(:to => email_with_name,
         :subject => "Round confirmation")
  end
end
