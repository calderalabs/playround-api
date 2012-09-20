FactoryGirl.define do
  factory :comment do |comment|
    comment.association :user
    comment.association :round
    comment.text 'Amazing comment'
  end
end