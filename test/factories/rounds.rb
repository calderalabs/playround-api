Factory.sequence :name do |n|
  "DotA Match#{n}"
end

Factory.define :round, :class => Round do |round|
  round.name { Factory.next :name }
  round.max_people 1
  round.min_people 1
  round.association :arena
  round.association :game
end