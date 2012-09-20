FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do |user|
    user.email    { generate :email }
    user.password { "password" }
  end

  factory :user_with_quicktour, :parent => :user do |user|
    user.after_build { |u| u.quicktour = FactoryGirl.build(:quicktour, :user => u) }
  end

  factory :email_confirmed_user, :parent => :user do |user|
    user.after_build { warn "[DEPRECATION] The :email_confirmed_user factory is deprecated, please use the :user factory instead." }
  end
end