
require 'nokogiri'
require 'open-uri'

n = 0..5

SportCombination.destroy_all
Message.destroy_all
Chatroom.destroy_all
Place.destroy_all
SportType.destroy_all
User.destroy_all


# create sport types and chatrooms
%w(Basketball Ping-Pong Surf Calisthetics).each do |sporttype|
  sport = SportType.new(name: sporttype)
  sport.photo.attach(io: File.open("app/assets/images/#{sporttype}.png"), filename: "#{sporttype}.png", content_type: 'image/png')
  sport.save
  chat = Chatroom.create(name: "#{sporttype} Chatroom", sport_type: sport)
end


# create users
arko = User.create(email: "arko@hotmail.com", password: "1234567", first_name: "Armen", last_name: "Kaltak")
isa = User.create(email: "isa@hotmail.com", password: "1234567", first_name: "Isabella", last_name: "Hoesch")
tea = User.create(email: "tea@hotmail.com", password: "1234567", first_name: "Tea", last_name: "Filipovic")
andrea = User.create(email: "andrea@hotmail.com", password: "1234567", first_name: "Andrea", last_name: "Furthmair")


# create places: ping-pong
count = 0
document  = Nokogiri::XML(File.open('db/pingpong.xml'))
document.root.xpath('marker')[n].each do |pp|
  name = pp.attributes["id"]
  address = pp.attributes['ort']
  description = pp.attributes['info']
  foto = pp.attributes['foto']
  place = Place.new(name: "Ping-Pong table #{name}", address:address, description: description, user: arko)
  place.photos.attach(io: URI.open("#{foto}"), filename: "#{name}.png", content_type: 'image/png')
  place.sport_types.push(SportType.find_by(name: "Ping-Pong"))
  place.save
  count += 1
end
puts "#{count} Ping-Pong entries seeded"


# basketball
count = 0
# prep_url = "https://www.courtsoftheworld.com/germany/munich/"
# html_content = URI.open(prep_url).read
doc = Nokogiri::HTML(File.open('db/basketball.html'), nil, 'utf-8')
elements = doc.search('.owl-headline')
elements[n].each_with_index do |e, i|
  address =  e.text.strip
  address.sub! 'Munich', ' Munich'
  photo = "https://www.courtsoftheworld.com#{doc.css('div.owl-slide-parent a').map { |link| link['href'] }[i]}"
  p = Place.create(name: "Basketball #{i}", address: address, description: "missing description", user: isa)
  p.photos.attach(io: URI.open(photo), filename: "#{count}.png", content_type: 'image/png')
  p.sport_types.push(SportType.find_by(name: "Basketball"))
  p.save
  count += 1
end
puts "#{count} Basketball entries seeded"

# calisthetics 
calist = [
  "7059-en-munich-outdoor-gym-schwabing-west-ackermannbogen", "4375-en-munchen-calisthenics-equipment-olympiapark-playparc",
  "15582-en-outdoor-fitness-park-munich-bewegungspark-4f-circle-schwabing", "5264-en-munich-outdoor-pull-up-bars-christoph-von-gluck-platz",
  "84-en-calisthenics-street-workout-park-korbinianplatz-munich", "155-en-parkourpark-rote-stadt-munich",
  "6327-en-munich-outdoor-pull-up-bars-au-haidhausen", "1768-en-4fcircle-munich-moosach-outdoor-gym",
  "6326-en-munich-outdoor-fitness-station-schulsportanlage-an-der-schulstrasse", "16251-en-fitness-facility-munich-fitness-station-hypopark",
  "144-en-outdoor-fitnesspark-at-isarauen-munich", "4586-en-munich-parkour-park-ludwig-thoma-realschule",
  "6823-en-munich-calisthenics-park-stiftsbogen-hadern", "145-en-workout-park-at-munich-sudpark",
  "1760-en-fitness-trail-perlacher-forst-munich-outdoor-gym", "16632-en-outdoor-pull-up-bars-munich-outdoor-klimmzugstange-munchen",
  "10043-en-outdoor-pull-up-bars-munich-calisthenics-gym-obersendling", "16954-en-fitness-trail-munich-outdoor-fitness-sportanlage-an-der-wurm",
  "3007-en-munich-messestadt-riem-calisthenics-gerate-playparc-riemer-park", "1132-en-munich-outdoor-fitness-gym-fuerstenried",
  "8423-en-exercise-park-munich-outdoor-fitness-munchen-neuaubing-sportplatz", "838-en-parkour-park-munich-germering-harthaus-workout-spot",
  "5708-en-munich-outdoor-fitness-station-zugspitzstrasse-grunwald", "5183-en-munich-outdoor-fitness-trail-grunwalder-forst"
]

count = 0
calist[n].each do |cal|
  doc = Nokogiri::HTML(URI.open("https://calisthenics-parks.com/spots/#{cal}").read)
  foto = doc.at_css('#links > a > img').attr('src')
  name = doc.search('#well > h1').text.strip
  address = doc.xpath('//*[@id="content-l-container"]/address/text()').text.strip
  place = Place.new(name: "#{name}", address:address, description: "missing description", user: tea)
  place.photos.attach(io: URI.open("#{foto}"), filename: "#{name}.png", content_type: 'image/png')
  place.sport_types.push(SportType.find_by(name: "Calisthetics"))
  place.save
  count += 1
end
puts "#{count} Calisthetics entries seeded"


# create places: surf
surf1 = Place.new(name: "Eisbachwelle", address: "Prinzregentenstraße, 80538 München", description: "Da das Surfen hier technisch anspruchsvoll und das Verletzungsrisiko wegen zementierten Störsteinen unter Wasser besonders groß ist, dürfen hier auf Basis einer Vereinbarung mit den städtischen Behörden nur sehr geübte Surfer mit mehreren Jahren Erfahrung ins Wasser.", user: isa)
surf1.photos.attach(io: URI.open("https://cdn.muenchen-p.de/.imaging/stk/responsive/image980/dms/fg-2018/outdoor-sport/isarsurferin-hp/document/isarsurferin-hp.jpg"), filename: 'surf1.png', content_type: 'image/png')
surf1.sport_types.push(SportType.find_by(name: "Surf"))
surf1.save

surf2 = Place.new(name: "E2/Dianabadschwelle", address: "Himmelreichstraße, 80538, Munich", description: "Das Surfen an der Dianabadschwelle ist nicht legal und wird von der Stadt nur geduldet.", user: isa)
surf2.photos.attach(io: URI.open("https://www.igsm.info/wp-content/uploads/2015/08/Dianabadschwelle.jpg"), filename: 'surf2.png', content_type: 'image/png')
surf2.sport_types.push(SportType.find_by(name: "Surf"))
surf2.save

surf3 = Place.new(name: "Floßlände", address: "Floßlände, Munich", description: "Die Welle läuft während der Floßsaison von Mai bis Oktober.", user: isa)
surf3.photos.attach(io: URI.open("https://www.sueddeutsche.de/image/sz.1.4925326/1200x675?v=1591172107"), filename: 'surf3.png', content_type: 'image/png')
surf3.sport_types.push(SportType.find_by(name: "Surf"))
surf3.save

puts "3 Surf entries seeded"
