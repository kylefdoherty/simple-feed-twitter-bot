require "ap"

module FeedParser #turn this into a module 

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
			items << attributes
		end 
		return items_array
	end 


	def self.atom_parser(atom)
		items_array = []
		atom.items.each do |item| 
			attributes = []
			title = item.title
			link = item.link
			std_pub_date = Time.parse(item.pubDate.to_s).utc
			attributes.push(title,link,std_pub_date)
			items << attributes
		end 
		return items_array
	end 

end



Item = Struct.new(:title, :url, :pub_date, :parent_feed) #item struct to create a class with these 4 attributes - a Feed object has many of these item objects




class Feed 
	attr_reader :name

	def initialize(name, url)
		@name = name
		@url = url 
		@items = [] #array of item objects
		create_item
	end 

	def create_item 
		array = FeedParser.feed_sorter(@url)
		array.each do |a|
			puts a
			item = Item.new(a[0],a[1],a[2],@name)
			@items << item
			puts "Created a new item: #{item.title} from the #{item.parent_feed} feed"
		end 
		ap @items
	end 
end 

 

feed = Feed.new("UT", "http://www.utsandiego.com/rss/headlines/sports/sdsu-aztecs/")



#create a struct for item that has @title, @url, @pubdate, @parent_feed 
#have the feed class create items and store them in the @items array
