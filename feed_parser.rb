require 'rss'
require 'open-uri'
require 'twitter'

class FeedParser 

	def initialize(*feeds)
		@feeds = feeds 
		
	end 

	def run 
		feed_sorter
	end 

# method that sorts feeds
	def feed_sorter
		@feeds.each do |url|
			open(url) do |rss|
  			feed = RSS::Parser.parse(rss)
			
				case 
				when feed.feed_type == "rss"
					puts "rss"
					rss_parser(feed)
				when feed.feed_type == "atom"
					puts "atom"
					atom_parser(feed) 
				end 
			end 
		end 
	end 

	def rss_parser(rss)
		rss.items.each {|item| puts "#{item.title} #{item.link}"}
	end 


	def atom_parser(atom)
		atom.items.each do |item| 
			puts "#{item.title.content} #{item.link.href}"
		end 
	end 






end 




puts "hola"
parser = FeedParser.new('https://gdata.youtube.com/feeds/api/users/goaztecscom/uploads', 'http://www.utsandiego.com/rss/headlines/sports/sdsu-aztecs/')
parser.run