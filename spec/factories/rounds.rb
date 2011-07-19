Factory.define :round, :class => Round do |round|
  round.max_people 10
  round.min_people 2
  round.association :arena
  round.association :game
  round.association :user
  round.date Time.now + 2.months
  round.deadline Time.now + 1.month
  round.approved false
end