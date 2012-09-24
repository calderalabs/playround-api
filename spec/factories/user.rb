FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email { generate :email }
    password "password"
  end

  factory :user_with_quicktour, :parent => :user do |user|
    user.after(:build) { |u| u.quicktour = FactoryGirl.build(:quicktour, :user => u) }
  end
end