module FeedParser 

require 'rss'
require 'open-uri'

	def self.feed_sorter(url)	
		open(url) do |rss|
  		feed = RSS::Parser.parse(rss)
			
		case 
			when feed.feed_type == "rss"
				rss_parser(feed)
			when feed.feed_type == "atom"
				atom_parser(feed) 
			end 
		end 
	end 

	def self.rss_parser(rss)
		items_array = [] #creates an items array to store each item
		rss.items.each do |item| #parses through the items pulling out the title, link, and pub_date and stores them in an array, which is then put in the items_array and returned to be used by the Feed class to create an item
			attributes = []
			title = item.title
			link = item.link
			std_pub_date = Time.parse(item.pubDate.to_s).utc
			attributes.push(title,link,std_pub_date)
			items_array << attributes
		end 
		return items_array
	end 


	def self.atom_parser(atom)
		items_array = []
		atom.items.each do |item| 
			attributes = []
			title = item.title.content
			link = item.link.href
			std_pub_date = Time.parse(item.published.content.to_s).utc
			attributes.push(title,link,std_pub_date)
			items_array << attributes
		end 
		return items_array
	end 

end
