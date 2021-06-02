# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'nokogiri'

SportType.destroy_all
Place.destroy_all
User.destroy_all


# create sport types
%w(Basketball Football Ping-Pong Calesthetics Surf Volleyball Trampoline).each do |sport|
  SportType.create(name: sport)
end

# create users
arko = User.create(email: "arko@hotmail.com", password: "1234567")
isa = User.create(email: "isa@hotmail.com", password: "1234567")
tea = User.create(email: "tea@hotmail.com", password: "1234567")
andrea = User.create(email: "andrea@hotmail.com", password: "1234567")


# create places: ping-pong
file      = File.open("pingpong.xml") # won´t find path, why?
document  = Nokogiri::XML(file)

document.root.xpath('pingpong').each do |pp|
  name = pp.xpath('id').text
  name.sub! 'M&#252;nchen', 'München'
  address = pp.xpath('ort').text
  description = pp.xpath('info').text
  foto = pp.xpath('foto').text

  place = Place.new(name: "Ping-Pong #{name}", address:address, description: description, user: arko)
  place.photos.attach(io: URI.open("#{foto}"), filename: '1.png', content_type: 'image/png')
  place.sport_types.push("Ping-Pong")
  place.save
end

# basketball --> check test_file

# create places: surf
surf1 = Place.new(name: "Eisbachwelle", address: "Prinzregentenstraße, 80538 München", description: "Da das Surfen hier technisch anspruchsvoll und das Verletzungsrisiko wegen zementierten Störsteinen unter Wasser besonders groß ist, dürfen hier auf Basis einer Vereinbarung mit den städtischen Behörden nur sehr geübte Surfer mit mehreren Jahren Erfahrung ins Wasser.", user: isa)
surf1.photos.attach(io: URI.open("https://www.sueddeutsche.de/muenchen/muenchen-surfen-eisbach-wellen-probleme-1.4623618"), filename: '1.png', content_type: 'image/png')
surf1.sport_types.push("Surf")
surf1.save

surf2 = Place.new(name: "E2/Dianabadschwelle", address: "Flurstrasse 12, Munich", description: "Das Surfen an der Dianabadschwelle ist nicht legal und wird von der Stadt nur geduldet.", user: isa)
surf2.photos.attach(io: URI.open("https://www.igsm.info/wp-content/uploads/2015/08/Dianabadschwelle.jpg"), filename: '1.png', content_type: 'image/png')
surf2.sport_types.push("Surf")
surf2.save

surf3 = Place.new(name: "Floßlände", address: "Flurstrasse 12, Munich", description: "Die Welle läuft während der Floßsaison von Mai bis Oktober.", user: isa)
surf3.photos.attach(io: URI.open("https://www.sueddeutsche.de/image/sz.1.4925326/1200x675?v=1591172107"), filename: '1.png', content_type: 'image/png')
surf3.sport_types.push("Surf")
surf3.save
