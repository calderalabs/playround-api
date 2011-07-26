Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user, :class => User do |user|
  user.email    { Factory.next :email }
  user.password { "password" }
end

Factory.define :user_with_quicktour, :class => User do |user|
  user.email    { Factory.next :email }
  user.password { "password" }
  user.after_build { |u| u.quicktour = Factory.build(:quicktour, :user => u) }
end

Factory.define :email_confirmed_user, :parent => :user do |user|
  user.after_build { warn "[DEPRECATION] The :email_confirmed_user factory is deprecated, please use the :user factory instead." }
end
