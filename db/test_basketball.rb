
require 'nokogiri'
require 'open-uri'

prep_url = "https://www.courtsoftheworld.com/germany/munich/"
html_content = URI.open(prep_url).read
doc = Nokogiri::HTML(html_content)
elements = doc.search('.owl-headline')
elements.each_with_index do |e, i|
  address =  e.text.strip
  photo = "https://www.courtsoftheworld.com#{doc.css('div.owl-slide-parent a').map { |link| link['href'] }[i]}"
  p = Place.create(name: "Basketball #{i}", address: address, description: "missing description", user: isa)
  p.photos.attach(io: URI.open(photo), filename: '1.png', content_type: 'image/png')
  p.sport_types.push("Basketball")
  p.save
end
