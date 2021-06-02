# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
SportCombination.destroy_all
Visit.destroy_all
Place.destroy_all
User.destroy_all
SportType.destroy_all

%w(Basketball Football Ping-Pong Calesthetics Surf Volleyball Trampoline).each do |sport|
  SportType.create(name: sport)
end




# photo1 = "https://heidelberger-tv.de/wp-content/uploads/miguel-teirlinck-VDkRsT649C0-unsplash_Volleyball-1-1080x675.jpg"
# offer = Offer.new(name: "Great volleyball", offer_type: "Equipment", description: "needs air pumping", sport_type: "Volleyball", address: "Schleißheimer Straße 60, München", offer_img: "#{photo1}", price: 20, user: user1)
# file = URI.open("#{photo1}")
# offer.photo.attach(io: file, filename: '1.png', content_type: 'image/png')
# offer.save

# @message.image.attach(io: File.open('/path/to/file'), filename: 'file.pdf')



arko = User.create(email: "arko@hotmail.com", password: "1234567")

place1 = Place.create(name: "IsartorBasket", address: "Praterinsel 4, Munich", description: "Who wants to play Basker or Ping Pong, it is a perfect place for it", user: arko)
place1.photos.attach(io: File.open('app/assets/images/sports_img.jpg'), filename: 'sports_img.jpg')


place2 = Place.create(name: "Mini Calisthenics Park", address: "Flurstrasse 12, Munich", description: "A pretty small StreetWorkOut Park.", user: arko)
place2.photos.attach(io: File.open('app/assets/images/sports_img.jpg'), filename: 'sports_img.jpg')
place3 = Place.create(name: "Hypopark", address: "Elsässer Strasse 6, Munich", description: "A small Park near Munich East Station. Next to the walk you can enjoy your freetime with skating.", user: arko)
place3.photos.attach(io: File.open('app/assets/images/sports_img.jpg'), filename: 'sports_img.jpg')
place4 = Place.create(name: "Hirschau", address: "Gyßlingstrasse 15, Munich", description: "Four beautiful tennis courts in the center of English Garden.", user: arko)
place4.photos.attach(io: File.open('app/assets/images/sports_img.jpg'), filename: 'sports_img.jpg')
place5 = Place.create(name: "MiniGolf OlyPark", address: "Spiridon-Louis-Ring 22, Munich", description: "18 mini golf course different shapes.", user: arko)
place5.photos.attach(io: File.open('app/assets/images/sports_img.jpg'), filename: 'sports_img.jpg')


Place.all.each do |place|
  rand(1..2).times do
    place.sport_types.push(SportType.all.sample)
  end
end
