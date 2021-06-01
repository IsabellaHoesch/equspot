# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Place.destroy_all
arko = User.new(email: "arko@hotmail.com", password: "1234567")
place1 = Place.new(name: "IsartorBasket", address: "Praterinsel 4, Munich", description: "Who wants to play Basker or Ping Pong, it is a perfect place for it", user: arko)
place2 = Place.new(name: "Mini Calisthenics Park", address: "Flurstrasse 12, Munich", description: "A pretty small StreetWorkOut Park.", user: arko)
place3 = Place.new(name: "Hypopark", address: "Elsässer Strasse 6, Munich", description: "A small Park near Munich East Station. Next to the walk you can enjoy your freetime with skating.", user: arko)
place4 = Place.new(name: "Hirschau", address: "Gyßlingstrasse 15, Munich", description: "Four beautiful tennis courts in the center of English Garden.", user: arko)
place5 = Place.new(name: "MiniGolf OlyPark", address: "Spiridon-Louis-Ring 22, Munich", description: "18 mini golf course different shapes.", user: arko)
