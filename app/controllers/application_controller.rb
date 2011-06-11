class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url, :status => :unauthorized
  end
  
  def get_user_location
    if session[:near]
      @location = Geocoder.search(session[:near]).first
    else
      @location = request.location
    end
  end
  
  def user_located?
    !!@location
  end
end
