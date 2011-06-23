Factory.define :subscription, :class => Subscription do |subscription|
  subscription.association :round
  subscription.association :user
end
