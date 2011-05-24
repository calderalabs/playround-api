class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :round
  
  validates_presence_of :user_id
  validates_presence_of :round_id
  validates_uniqueness_of :round_id, :scope => :user_id, :message => "- this subscription has already been created"
end
