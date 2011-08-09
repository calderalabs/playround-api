module ApplicationHelper
  def location_name(location)
    [location.name, location.country].join(', ')
  end
end
