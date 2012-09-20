FactoryGirl.define do
  factory :quicktour do |f|
    f.association :user
    f.current_guider 0
  end
end