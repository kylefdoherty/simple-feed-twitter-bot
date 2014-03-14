require 'time'
require_relative 'feed_parser'

Item = Struct.new(:title, :url, :pub_date, :parent_feed) #item struct to create a class with these 4 attributes - a Feed object has many of these item objects

class Feed
	attr_reader :name, :url

	def initialize(name, url)
		@name = name
		@url = url
		@items = []
		create_item
	end 

	def create_item 
		array = FeedParser.feed_sorter(@url)
		array.each do |a|
			item = Item.new(a[0],a[1],a[2],@name)
			@items << item
		end 
	end 

	def items_to_tweet
		contents = File.open("last_tweet.txt", "r") {|f| f.read}
		@items.each do |item|
			if item.pub_date > Time.parse(contents)
				puts "\nTitle: #{item.title}"
				puts "URL: #{item.url}"
				puts "Pub Date: #{item.pub_date}"
				puts "Parent Feed: #{item.parent_feed}"
			else 
				puts "***************** TO OLD ************************"
			end 
		end 
	end 




end 


if $0 == __FILE__

	feed = Feed.new("GoAztecs", 'https://gdata.youtube.com/feeds/api/users/goaztecscom/uploads')
	feed.items_to_tweet

end 