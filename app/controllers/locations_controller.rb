class LocationsController < ApplicationController
  def update
    places = GeoPlanet::Place.search(params[:location])
    location = places.first if places
    
    if signed_in?
      current_user.town_woeid = location.woeid if location
      current_user.save!
    end
    
    set_location(location)
    
    redirect_to params[:redirect_to]
  end
end
