class ApplicationController < ActionController::Base
  helper_method :located?, :current_location
  include Clearance::Authentication
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html {
        flash[:error] = t('controllers.access_denied')
        redirect_to sign_in_url 
        }
      format.json  { head :unauthorized }
    end
    
  end
  
  before_filter :set_timezone
  before_filter :set_locale
  
  def set_locale
    locale = nil

    # http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4
    if lang = env["HTTP_ACCEPT_LANGUAGE"]
      lang = lang.split(",").map { |l|
        l += ';q=1.0' unless l =~ /;q=\d+\.\d+$/
        l.split(';q=')
      }.first
      locale = lang.first.split("-").first
    else
      locale = I18n.default_locale
    end
    
    I18n.locale = params[:locale] || I18n.locale.to_s
  end

  def set_timezone
    Time.zone = current_timezone
  end
  
  def located?
    !!current_location
  end
  
  def current_timezone
    set_location_from_user_or_session_or_ip unless @location
    @timezone ||= session[:timezone] || Time.zone
  end
  
  def current_location
    @location ||= set_location_from_user_or_session_or_ip
  end
  
  def set_location(location)
    return unless location.try(:placetype_code) == 7
    
    session[:location] = location
    session[:timezone] = location.try(:belongtos, { :type => 31 }).try(:first).try(:name)
  end
  
  private
  
  def set_location_from_user_or_session_or_ip
    location = GeoPlanet::Place.new(current_user.town_woeid) if signed_in? && current_user.town_woeid
    location ||= session[:location]
    location ||= GeoPlanet::Place.search(request.location.try(:address).to_s).try(:first)
    
    set_location(location)
    
    location
  end
  
  def clear_location!
    session[:location] = nil
    session[:timezone] = nil
  end
end
