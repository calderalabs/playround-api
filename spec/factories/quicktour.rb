Factory.define :quicktour, :class => Quicktour do |f|
  f.association :user
  f.current_guider 0
end