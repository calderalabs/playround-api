Factory.define :subscription, :class => Subscription do |subscription|
  subscription.association :user
end
