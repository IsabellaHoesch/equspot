
require 'nokogiri'
require 'open-uri'
require 'date'

num = 20
n = 0..num

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
month = 2
10.times do
  rand(1..15).times do
    Visit.create!(user: isa, place: surf1, created_at: DateTime.new(2020,month,3,4,5,6))
  end
  month += 1
end

surf2 = Place.new(name: "E2/Dianabadschwelle", address: "Himmelreichstraße, 80538, Munich", description: "Surfing here is officially not legal. Please surf quietly here.", user: isa)
surf2.photos.attach(io: URI.open("https://www.igsm.info/wp-content/uploads/2015/08/Dianabadschwelle.jpg"), filename: 'surf2.png', content_type: 'image/png')
surf2.photos.attach(io: URI.open("https://www.sueddeutsche.de/image/sz.1.4052808/704x396?v=1531431532"), filename: 'surf22.png', content_type: 'image/png')
surf2.sport_types.push(SportType.find_by(name: "Surf"))
surf2.save!
Visit.create(user: tea, place: surf2, created_at: DateTime.new(2021,7,6,4,5,6))

surf3 = Place.new(name: "Floßlände", address: "Floßlände, Munich", description: "Great for beginners. You can surf here from May to October.", user: isa)
surf3.photos.attach(io: URI.open("https://www.sueddeutsche.de/image/sz.1.4925326/1200x675?v=1591172107"), filename: 'surf3.png', content_type: 'image/png')
surf3.sport_types.push(SportType.find_by(name: "Surf"))
surf3.save!
puts "3 Surf entries seeded"

# calisthetics
count = 0
CSV.foreach("db/calisthetics.csv") do |row|
  #if count <= num
    foto = ["https://www.hall-of-sports.de/wp-content/uploads/2018/08/E3A1715-1030x686.jpg", "https://assets.sweat.com/html_body_blocks/images/000/016/679/original/CalisthenicsForBeginners_enf24172b519690b056a24f2dfcf358ec1.jpg?1583473329"].sample
    foto1 = "https://hips.hearstapps.com/ame-prod-menshealth-assets.s3.amazonaws.com/main/assets/human_flag.jpg?resize=480:*" #row[0]
    name = row[1]
    address = row[2]
    place = Place.new(name: name, address:address, description: name, user: tea)
    place.photos.attach(io: URI.open("#{foto}"), filename: "#{name}.jpg", content_type: 'image/png')
    place.photos.attach(io: URI.open("#{foto1}"), filename: "#{name}1.jpg", content_type: 'image/png')
    place.sport_types.push(SportType.find_by(name: "Calisthenics"))
    place.save!
    count += 1
    # add some visits
    [arko, isa, andrea].sample do |user|
      rand(0..2).times do
        Visit.create!(user: user, place: place)
      end
    end
    # add some visits for Tea!
    rand(2..4).times do
      Visit.create!(user: tea, place: place)
    end

  #end
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
  place = Place.new(name: "Ping-Pong table #{name}", address:address, description: description, user: arko)
  place.photos.attach(io: URI.open("#{foto}"), filename: "#{name}.png", content_type: 'image/png')
  place.sport_types.push(SportType.find_by(name: "Ping-Pong"))
  place.save
  # add visits
  if count <= 2
    month = 1
    12.times do
      rand(2..6).times do
        Visit.create(user: tea, place: place, created_at: DateTime.new(2020,month,3,4,5,6))
      end
      month += 1
    end
    month = 1
    7.times do
      rand(1..5).times do
        Visit.create(user: tea, place: place, created_at: DateTime.new(2021,month,8,4,5,6))
        Visit.create(user: isa, place: place, created_at: DateTime.new(2021,month,6,4,5,6))
      end
      month += 1
      # add reviews
      Review.create(user: andrea, place: place, content: "Nice place to play PingPong", rating: 4)
    end
  end
  count += 1
end
puts "#{count} Ping-Pong entries seeded"


# basketball
count = 0
# prep_url = "https://www.courtsoftheworld.com/germany/munich/"
# html_content = URI.open(prep_url).read
doc = Nokogiri::HTML(File.open('db/basketball.html'), nil, 'utf-8')
elements = doc.search('.owl-headline')
#elements[n].each_with_index do |e, i|
elements.each_with_index do |e, i|
  address =  e.text.strip
  address.sub! 'Munich', ' Munich'
  photo = "https://www.courtsoftheworld.com#{doc.css('div.owl-slide-parent a').map { |link| link['href'] }[i]}"
  p = Place.create(name: "Basketball #{i}", address: address, description: "", user: isa)
  p.photos.attach(io: URI.open(photo), filename: "#{count}.png", content_type: 'image/png')
  p.sport_types.push(SportType.find_by(name: "Basketball"))
  p.save
  count += 1
  # add some visits
  rand(0..2).times do
    Visit.new(user: tea, place: p)
  end
end
puts "#{count} Basketball entries seeded"



# busy spot for demo
demo_spot_busy = "Ping-Pong table 2679"

# visits:
Visit.create(user: andrea, place: Place.find_by(name: demo_spot_busy), created_at: DateTime.new(2021,7,11,16,5,6))
Visit.create(user: isa, place: Place.find_by(name: demo_spot_busy), created_at: DateTime.new(2021,7,11,16,5,6))
Visit.create(user: arko, place: Place.find_by(name: demo_spot_busy), created_at: DateTime.new(2021,7,11,16,5,6))
Visit.create(user: andrea, place: Place.find_by(name: demo_spot_busy), created_at: DateTime.new(2021,7,11,16,5,6))

# reviews:
Review.create(user: andrea, place: Place.find_by(name: demo_spot_busy), content: "Always looking for more players! Feel free to join every Tuesday 7pm", rating: 5)
Review.create(user: arko, place: Place.find_by(name: demo_spot_busy), content: "Love this place. Great people every time", rating: 5)
Review.create(user: arko, place: Place.find_by(name: demo_spot_busy), content: "Ruined too many rackets here already", rating: 5)


# busy spot for demo
demo_spot_hated = "Ping-Pong table 504"

# visits:
Visit.create(user: andrea, place: Place.find_by(name: demo_spot_hated), created_at: DateTime.new(2021,7,11,16,5,6))

# reviews:
Review.create(user: andrea, place: Place.find_by(name: demo_spot_hated), content: "Why is this place always dirty?", rating: 1)
Review.create(user: arko, place: Place.find_by(name: demo_spot_hated), content: "Stepped on a rat the other day .. I just can´t ..", rating: 2)
Review.create(user: arko, place: Place.find_by(name: demo_spot_hated), content: "Nope, this place is shady!", rating: 3)


# favourites
Favourite.create(user: tea, place: Place.find_by(name: demo_spot_busy))
Favourite.create(user: tea, place: Place.find_by(name: "Ping-Pong table 3564"))
Favourite.create(user: tea, place: Place.find_by(name: "Ping-Pong table 4782"))
Favourite.create(user: tea, place: Place.find_by(name: "Ping-Pong table 4854"))
Favourite.create(user: tea, place: Place.find_by(name: "Ping-Pong table 6163"))
Favourite.create(user: tea, place: Place.find_by(name: "Bewegungspark 4F Circle Schwabing"))
Favourite.create(user: tea, place: Place.find_by(name: "Eisbachwelle"))


Favourite.create(user: isa, place: Place.find_by(name: demo_spot_busy))
Favourite.create(user: isa, place: Place.find_by(name: "Eisbachwelle"))
Review.create(user: arko, place: Place.find_by(name: "Eisbachwelle"), content: "Crowded at every hour...", rating: 2)
Review.create(user: andrea, place: Place.find_by(name: "Eisbachwelle"), content: "Coming here makes me happy every time", rating: 5)
