FactoryGirl.define do
  sequence :game_name do |n|
    "DotA#{n}"
  end

  factory :game do |game|
    game.association :user
    game.name { generate :game_name }
    game.description "Defense of the Ancients (commonly known as DotA) is a custom scenario for the real-time strategy video game Warcraft III"
    game.website "http://en.wikipedia.org/wiki/Defense_of_the_Ancients"
  end
end