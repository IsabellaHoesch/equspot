
require 'nokogiri'
require 'open-uri'

SportCombination.destroy_all
Message.destroy_all
Chatroom.destroy_all
Place.destroy_all
SportType.destroy_all
User.destroy_all


# create sport types and chatrooms
%w(Basketball Ping-Pong Surf).each do |sporttype|
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
document.root.xpath('marker').each do |pp|
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


# basketball --> check test_file



count = 0
# prep_url = "https://www.courtsoftheworld.com/germany/munich/"
# html_content = URI.open(prep_url).read
doc = Nokogiri::HTML(File.open('db/basketball.html'), nil, 'utf-8')
elements = doc.search('.owl-headline')
elements.each_with_index do |e, i|
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

# calisthetics --> check test_file


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
