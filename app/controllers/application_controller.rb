class ApplicationController < ActionController::Base
  helper_method :located?, :current_location
  include Clearance::Authentication
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to sign_in_url, :status => :unauthorized
  end
  
  def located?
    !!current_location
  end
  
  def current_location
    @location ||= location_from_session_or_user_or_ip
  end
  
  def set_location(location)
    return nil unless location && location.placetype_code == 7
    
    session[:location] = location
  end
  
  private
  
  def location_from_session_or_user_or_ip
    location = session[:location]
    location ||= GeoPlanet::Place.new(current_user.town_woeid) if signed_in?
    
    unless location
      places = GeoPlanet::Place.search(request.location.address) if request.location
      location = places.first if places
    end
    
    set_location(location)
    
    location
  end
  
  def clear_location!
    session[:location] = nil
  end
end
