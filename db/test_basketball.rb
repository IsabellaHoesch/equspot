require 'nokogiri'
require 'open-uri'

# in case need to seed better
count = 0
doc = Nokogiri::HTML(URI.open("https://www.courtsoftheworld.com/germany/munich/").read)
elements = doc.search('.owl-headline')


elements.each_with_index do |e, i|
  photo = "https://www.courtsoftheworld.com#{doc.css('div.owl-slide-parent a').map { |link| link['href'] }[i]}"
  name =  e.text.strip
  doc = Nokogiri::HTML(URI.open("https://www.courtsoftheworld.com/germany/#{name}/").read)
  address = doc.search('.body > main > section:nth-child(3) > div > div > div > div > div:nth-child(4) > div > div.location-properties__content > p.text-larger.text-bold')
  count += 1
end

puts "#{count} Basketball entries seeded"


