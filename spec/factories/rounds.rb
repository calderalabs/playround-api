FactoryGirl.define do
  factory :round do |round|
    round.people 10
    round.association :arena
    round.association :game
    round.association :user
    round.date Time.now + 2.months
  end

  factory :approved_round, :parent => :round do |round|
    round.state 'approved'
  end
end
