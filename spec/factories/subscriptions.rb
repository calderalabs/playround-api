FactoryGirl.define do
  factory :subscription do |subscription|
    subscription.association :user
  end
end
