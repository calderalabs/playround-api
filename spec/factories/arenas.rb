#encoding: utf-8
FactoryGirl.define do
  sequence :arena_name do |n|
    "Tea Room#{n}"
  end

  factory :arena do
    user
    name { generate :arena_name }
    latitude 43.31706
    longitude 11.333599
    description "Sala da thè più famosa"
    website "http://www.facebook.com/group.php?gid=59769240464&v=info"
    address "Via di Porta Giustizia, 11, 53100 Siena, Italy"
    town_woeid 724196
    public true
  end
end