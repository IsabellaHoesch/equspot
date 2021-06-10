require 'nokogiri'
require 'open-uri'
require 'date'

SportCombination.destroy_all
Message.destroy_all
Chatroom.destroy_all
Place.destroy_all
SportType.destroy_all
User.destroy_all
Review.destroy_all
Visit.destroy_all
ChatroomVisit.destroy_all

# create sport types and chatrooms
%w(Basketball Ping-Pong Surf Calisthenics).each do |sporttype|
  sport = SportType.new(name: sporttype)
  sport.photo.attach(io: File.open("app/assets/images/#{sporttype}.png"), filename: "#{sporttype}.png", content_type: 'image/png')
  sport.save
  chat = Chatroom.create(name: "#{sporttype} Chatroom", sport_type: sport)
end


# create users
arko = User.create!(email: "arko@hotmail.com", password: "1234567", first_name: "Armen", last_name: "Kaltak")
isa = User.create!(email: "isa@hotmail.com", password: "1234567", first_name: "Isabella", last_name: "Hoesch")
tea = User.create!(email: "tea@hotmail.com", password: "1234567", first_name: "Tea", last_name: "Filipovic")
andrea = User.create!(email: "andrea@hotmail.com", password: "1234567", first_name: "Andrea", last_name: "Furthmair")

# create places: surf
surf1 = Place.new(name: "Eisbachwelle", address: "Prinzregentenstraße, 80538 München", description: "Risk of injury is high due to cemented rocks in water.", user: isa)
surf1.photos.attach(io: URI.open("https://cdn.muenchen-p.de/.imaging/stk/responsive/image980/dms/fg-2018/outdoor-sport/isarsurferin-hp/document/isarsurferin-hp.jpg"), filename: 'surf1.png', content_type: 'image/png')
surf1.photos.attach(io: URI.open("https://www.travelontoast.de/wp-content/uploads/2018/03/4-Eisbachwelle-M%C3%BCnchen-Surfen-Wellenreiten-Bayern-Deutschland-.jpg"), filename: 'surf12.png', content_type: 'image/png')
surf1.photos.attach(io: URI.open("https://www.spurwechsel-muenchen.de/wp-content/uploads/2018/08/Eisbachwelle-M%C3%BCnchen4.jpg"), filename: 'surf13.png', content_type: 'image/png')
surf1.sport_types.push(SportType.find_by(name: "Surf"))
surf1.save!

surf2 = Place.new(name: "E2/Dianabadschwelle", address: "Himmelreichstraße, 80538, Munich", description: "Surfing here is officially not legal. Please surf quietly here.", user: isa)
surf2.photos.attach(io: URI.open("https://www.igsm.info/wp-content/uploads/2015/08/Dianabadschwelle.jpg"), filename: 'surf2.png', content_type: 'image/png')
surf2.photos.attach(io: URI.open("https://www.sueddeutsche.de/image/sz.1.4052808/704x396?v=1531431532"), filename: 'surf22.png', content_type: 'image/png')
surf2.sport_types.push(SportType.find_by(name: "Surf"))
surf2.save!

surf3 = Place.new(name: "Floßlände", address: "Floßlände, Munich", description: "Great for beginners. You can surf here from May to October.", user: isa)
surf3.photos.attach(io: URI.open("https://www.sueddeutsche.de/image/sz.1.4925326/1200x675?v=1591172107"), filename: 'surf3.png', content_type: 'image/png')
surf3.sport_types.push(SportType.find_by(name: "Surf"))
surf3.save!
puts "3 Surf entries seeded"

# calisthetics
count = 0
CSV.foreach("db/calisthetics.csv") do |row|
  foto = ["https://www.hall-of-sports.de/wp-content/uploads/2018/08/E3A1715-1030x686.jpg", "https://assets.sweat.com/html_body_blocks/images/000/016/679/original/CalisthenicsForBeginners_enf24172b519690b056a24f2dfcf358ec1.jpg?1583473329"].sample
  name = row[1]
  address = row[2]
  place = Place.new(name: name, address:address, description: name, user: tea)
  place.photos.attach(io: URI.open("#{foto}"), filename: "#{name}.jpg", content_type: 'image/png')
  place.sport_types.push(SportType.find_by(name: "Calisthenics"))
  place.save!
  count += 1
end
puts "#{count} Calisthenics entries seeded"


# create places: ping-pong
count = 0
document  = Nokogiri::XML(File.open('db/pingpong.xml'))
document.root.xpath('marker').each do |pp| #[n]
  name = pp.attributes["id"]
  address = pp.attributes['ort']
  description = pp.attributes['info']
  foto = pp.attributes['foto']
  place = Place.new(name: name, address:address, description: description, user: arko)
  place.photos.attach(io: URI.open("#{foto}"), filename: "#{count}.png", content_type: 'image/png')
  place.sport_types.push(SportType.find_by(name: "Ping-Pong"))
  place.save!
  count += 1
end
puts "#{count} Ping-Pong entries seeded"


# basketball
count = 0
# prep_url = "https://www.courtsoftheworld.com/germany/munich/"
# html_content = URI.open(prep_url).read
doc = Nokogiri::HTML(File.open('db/basketball.html'), nil, 'utf-8')
elements = doc.search('.owl-headline')
elements.each_with_index do |e, i|
  address =  e.text.strip
  address.sub! 'Munich', ' Munich'
  photo = "https://www.courtsoftheworld.com#{doc.css('div.owl-slide-parent a').map { |link| link['href'] }[i]}"
  p = Place.create(name: "Basketball #{i}", address: address, description: "", user: isa)
  p.photos.attach(io: URI.open(photo), filename: "#{count}.png", content_type: 'image/png')
  p.sport_types.push(SportType.find_by(name: "Basketball"))
  p.save
  count += 1
end
puts "#{count} Basketball entries seeded"



# for demo
demo_spot_busy = "Ping Pong Party"   
demo_spot_hated = "Ping di Pong"  
tea_fav_visit = ["Basketball 9", "Ping Pong Party", "Grafitti Ping Pong", "Artsy PingPing", "Ping Pong Bunch", "Beer Pong", "Bewegungspark 4F Circle Schwabing", "Eisbachwelle"]

# favourites
tea_fav_visit.each do |place|
  Favourite.create(user: tea, place: Place.find_by(name: place))
end

# reviews - surf
Review.create(user: arko, place: surf1, content: "Crowded at every hour...", rating: 2)
Review.create(user: andrea, place: surf1, content: "Coming here makes me happy every time", rating: 5)
# reviews - ping pong loved spot 
Review.create(user: andrea, place: Place.find_by(name: demo_spot_hated), content: "Why is this place always dirty?", rating: 1)
Review.create(user: arko, place: Place.find_by(name: demo_spot_hated), content: "Stepped on a rat the other day .. I just can´t ..", rating: 2)
Review.create(user: arko, place: Place.find_by(name: demo_spot_hated), content: "Nope, this place is shady!", rating: 3)
# reviews - ping pong hated spot 
Review.create(user: andrea, place: Place.find_by(name: demo_spot_busy), content: "Always looking for more players! Feel free to join every Tuesday 7pm", rating: 5)
Review.create(user: arko, place: Place.find_by(name: demo_spot_busy), content: "Love this place. Great people every time", rating: 5)
Review.create(user: arko, place: Place.find_by(name: demo_spot_busy), content: "Ruined too many rackets here already", rating: 5)


# visits now -loved place:
[andrea, arko, isa, tea].sample do |user|
  tea_fav_visit.each do |place|
    rand(1..2).times do # random so that not all have the same number of visits
      Visit.create(user: user, place: Place.find_by(name: place), created_at: DateTime.new(2021,6,11,4,5,6), checkin: DateTime.new(2021,6,11,4,5,6))
    end
  end
end

# visits now - hated place:
Visit.create(user: andrea, place: Place.find_by(name: demo_spot_hated), created_at: DateTime.new(2021,6,11, 4,5,6), checkin: DateTime.new(2021,6,11, 4,5,6))

# visits over time: tea visited one place in her list every week over the past 2 years
#2020
month = 1
12.times do
  day = 5
  4.times do
    rand(1..2).times do
      Visit.create(user: tea, place: Place.find_by(name: tea_fav_visit.sample), created_at: DateTime.new(2020,month,6, 4,5,6), checkin: DateTime.new(2020,month,day, 4,5,6))
    end
    day += 5
  end
  month += 1
end

# 2021
month = 1
6.times do
  day = 5
  4.times do
    rand(0..3).times do
    Visit.create(user: tea, place: Place.find_by(name: tea_fav_visit.sample), created_at: DateTime.new(2021, month, 9, 4, 5, 6), checkin: DateTime.new(2021, month, 6, 4,5,6))
    end
    day += 5
  end
  month += 1
end