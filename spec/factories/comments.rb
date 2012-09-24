FactoryGirl.define do
  factory :comment do
    user
    round
    text 'Amazing comment'
  end
end