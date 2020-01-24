require 'rubygems'
require 'nokogiri'
require 'open-uri'
PAGE_URL = 'http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'

page = Nokogiri::HTML(open(PAGE_URL))

url_array = []
first_name = []
last_name = []
mail_array = []
final_array = []
i = 0

page.xpath("//div[3]/div/ul/li/a").each do |name|
  array = name.text.split(" ")
  array.delete_at(0)
  if array.size > 2
    first_name << array[0]
    last_name << array[1.. array.size].join('-')
  else
    first_name << array[0]
    last_name << array[1]
  end
end

page.xpath("//div[3]/div/ul/li/a/@href").each do |href|
  url_array << href
end
puts "Recup mail"
url_array.each do |html|
  page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/".concat(html)))
  mail = page.xpath("//a[starts-with(@href, 'mailto')]/text()")[1].text
  mail_array << mail
end
puts i
while i < first_name.size
  puts i
  hash = Hash.new
  hash = {"first_name" => first_name[i], "last_name" => last_name[i], "email" => mail_array[i]}
  final_array << hash.to_s
  i += 1
end

puts final_array.to_s