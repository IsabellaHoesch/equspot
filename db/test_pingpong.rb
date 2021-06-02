require 'nokogiri'



 #/home/isabella/code/IsabellaHoesch/equspot/db/pingpong.xml
document  = Nokogiri::XML(File.open('pingpong.xml'))

document.root.xpath('pingpong').each do |pp|
  name = pp.xpath('id').text
  name.sub! 'M&#252;nchen', 'München'
  address = pp.xpath('ort').text
  description = pp.xpath('info').text
  foto = pp.xpath('foto').text

  puts  "this is #{name}"
end


