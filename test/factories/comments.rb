Factory.define :comment, :class => Comment do |comment|
  comment.association :user
  comment.association :round
  comment.text 'Amazing comment'
end