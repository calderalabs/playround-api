FactoryGirl.define do
  sequence :game_name do |n|
    "DotA#{n}"
  end

  factory :game do
    user
    name { generate :game_name }
    description "Defense of the Ancients (commonly known as DotA) is a custom scenario for the real-time strategy video game Warcraft III"
    website "http://en.wikipedia.org/wiki/Defense_of_the_Ancients"
  end
end