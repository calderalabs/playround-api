Factory.define :round, :class => Round do |round|
  round.max_people 10
  round.min_people 2
  round.association :arena
  round.association :game
  round.association :user
end