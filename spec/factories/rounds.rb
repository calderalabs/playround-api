FactoryGirl.define do
  factory :round do
    people 10
    arena
    game
    user
    date Time.now + 2.months
  end

  factory :approved_round, :parent => :round do |round|
    state 'approved'
  end
end
