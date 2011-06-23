Factory.sequence :name do |n|
  "DotA#{n}"
end

Factory.define :game, :class => Game do |game|
  game.association :user
  game.name { Factory.next :name}
  game.description "Defense of the Ancients (commonly known as DotA) is a custom scenario for the real-time strategy video game Warcraft III"
  game.website "http://en.wikipedia.org/wiki/Defense_of_the_Ancients"
end