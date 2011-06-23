Factory.sequence :name do |n|
  "Tea Room#{n}"
end

Factory.define :arena, :class => Arena do |arena|
  arena.association :user
  arena.name { Factory.next :name }
  arena.latitude 43.31706
  arena.longitude 11.333599
  arena.description "Sala da thè più famosa"
  arena.website "http://www.facebook.com/group.php?gid=59769240464&v=info"
  arena.address "Via di Porta Giustizia, 11, 53100 Siena, Italy"
  arena.town_woeid 724196
end