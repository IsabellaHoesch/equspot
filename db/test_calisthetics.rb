
require 'nokogiri'
require 'open-uri'

calist = [
  "7059-en-munich-outdoor-gym-schwabing-west-ackermannbogen",
  "4375-en-munchen-calisthenics-equipment-olympiapark-playparc",
  "15582-en-outdoor-fitness-park-munich-bewegungspark-4f-circle-schwabing",
  "5264-en-munich-outdoor-pull-up-bars-christoph-von-gluck-platz",
  "84-en-calisthenics-street-workout-park-korbinianplatz-munich",
  "155-en-parkourpark-rote-stadt-munich",
  "6327-en-munich-outdoor-pull-up-bars-au-haidhausen",
  "1768-en-4fcircle-munich-moosach-outdoor-gym",
  "6326-en-munich-outdoor-fitness-station-schulsportanlage-an-der-schulstrasse",
  "16251-en-fitness-facility-munich-fitness-station-hypopark",
  "144-en-outdoor-fitnesspark-at-isarauen-munich",
  "4586-en-munich-parkour-park-ludwig-thoma-realschule",
  "6823-en-munich-calisthenics-park-stiftsbogen-hadern",
  "145-en-workout-park-at-munich-sudpark",
  "1760-en-fitness-trail-perlacher-forst-munich-outdoor-gym",
  "16632-en-outdoor-pull-up-bars-munich-outdoor-klimmzugstange-munchen",
  "10043-en-outdoor-pull-up-bars-munich-calisthenics-gym-obersendling",
  "16954-en-fitness-trail-munich-outdoor-fitness-sportanlage-an-der-wurm",
  "3007-en-munich-messestadt-riem-calisthenics-gerate-playparc-riemer-park",
  "1132-en-munich-outdoor-fitness-gym-fuerstenried",
  "8423-en-exercise-park-munich-outdoor-fitness-munchen-neuaubing-sportplatz",
  "838-en-parkour-park-munich-germering-harthaus-workout-spot",
  "5708-en-munich-outdoor-fitness-station-zugspitzstrasse-grunwald",
  "5183-en-munich-outdoor-fitness-trail-grunwalder-forst"
]



count = 0
# calist.each do |cal|
#   doc = Nokogiri::HTML(URI.open("https://calisthenics-parks.com/spots/#{cal}").read)
#   foto = doc.at_css('#links > a > img').attr('src')
#   name = doc.search('#well > h1').text.strip
#   address = doc.xpath('//*[@id="content-l-container"]/address/text()').text.strip
#   place.photos.attach(io: URI.open("#{foto}"), filename: "#{name}.png", content_type: 'image/png')
#   place.sport_types.push(SportType.where(name: "Calisthetics"))
#   place.save
#   count += 1
# end
# puts "#{count} Calisthetics entries seeded"
