require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

def coinmarket
	begin
		page  = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
		name , value , array = [], [], []
		hash = Hash.new
		
		# Getting all value
		page.xpath('//tr/td[5]/a').each do |x|
			value << x.text.delete('$,').to_f
		end
	
		# Getting all name
		page.xpath('//tr/td[3]/div').each do |x|
			name << x.text
		end

		# Putting them in an hash
		hash = name.zip(value)
		hash.each do |x| 
			array << {x[0] => x[1]}
		end
	
		rescue OpenURI::HTTPError => e
		if e.message == '404 Not Found'
			puts  e.message
		else
	  		raise e
		end
	end
	return array
end

puts coinmarket.to_s