# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
puts "Generating seeds"

matteo = User.new({ :email => "matteodepalo@mac.com", :password => "solidus", :town_woeid => 724196 })
matteo.save!

puts "Matteo was created" if !!matteo

eugenio = User.new({ :email => "eugeniodepalo@mac.com", :password => "solidus", :town_woeid => 724196 })
eugenio.save!

puts "Eugenio was created" if !!eugenio

depalo_house = Arena.new({ :name => "Depalo's House", :latitude => 43.328092, :longitude => 11.3157779000001, :description => "The best house in the world", :address => "Via Mentana 45, Siena", :public => true})
depalo_house.user_id = matteo.id
depalo_house.save!
puts "Depalo's House was created" if !!depalo_house

giorni_house = Arena.new({ :name => "Giorni's House", :latitude => 43.3361655, :longitude => 11.3023851, :description => "The worst house in the world", :address => "Via Sansedoni 3, Siena", :public => true})
giorni_house.user_id = eugenio.id
giorni_house.save!
puts "Giorni's House was created" if !!giorni_house

dota = Game.new({ :name => "DotA", :description => "Defense of the Ancients (commonly known as DotA) is a custom scenario 
                                                      for the real-time strategy video game Warcraft III: Reign of Chaos and its expansion, 
                                                      Warcraft III: The Frozen Throne, based on the \"Aeon of Strife\" map for StarCraft. 
                                                      The objective of the scenario is for each team to destroy the opponents' Ancients, 
                                                      heavily guarded structures at opposing corners of the map. Players use powerful units known as heroes, 
                                                      and are assisted by allied heroes and AI-controlled fighters called \"creeps\". 
                                                      As in role-playing games, players level up their heroes and use gold to buy equipment during the mission." })
dota.user_id = matteo.id   
dota.save!                                                                     
puts "Dota was created" if !!dota

risk = Game.new({ :name => "Risk!", :description => "Risk is a strategic board game, produced by Parker Brothers (now a division of Hasbro). 
                                                       It was invented by French film director Albert Lamorisse and originally released in 1957, 
                                                       as La Conquête du Monde (\"The Conquest of the World\"), in France. Risk is a turn-based game for two to six players. 
                                                       The standard version is played on a board depicting a political map of the Earth, 
                                                       divided into forty-two territories, which are grouped into six continents. 
                                                       The primary object of the game is \"world domination,\" or \"to occupy every territory on the board and in so doing, 
                                                       eliminate all other players.\" Players control armies with which they attempt to capture territories from other players, 
                                                       with results determined by dice rolls." })                                                     
risk.user_id = eugenio.id
risk.save!
puts "Risk was created" if !!risk  
                                     
dota_round = Round.new({ :date => Time.now + 1.month, :game_id => dota.id, :arena_id => depalo_house.id, :people => 10})
dota_round.user_id = eugenio.id
dota_round.save!
puts "DotA round was created" if !!dota_round  

risk_round = Round.new({ :date => Time.now + 1.month, :game_id => risk.id, :arena_id => giorni_house.id, :people => 10})
risk_round.user_id = matteo.id
risk_round.save!
puts "Risk round was created" if !!risk_round

puts "Done generating seeds"