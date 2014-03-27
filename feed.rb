require 'time'
require_relative 'feed_parser'
require 'ap'

Item = Struct.new(:title, :url, :pub_date) #item struct to create a class with these 4 attributes - a Feed object has many of these item objects

class Feed
	attr_reader :name, :url

	def initialize(name, url)
		@name = name
		@url = url
		@items = []
		@file = "#{@name}_last_tweet.txt"
		create_item
	end 

	def create_item 
		array = FeedParser.feed_sorter(@url) #call .feed_sorter method from the FeedParser module and pass in the feed's URL
		array.each do |a|					 #this parses out the feed items and stores them in an array which in turn is stored by the array variable
			item = Item.new(a[0],a[1],a[2]) #gets the item title, URL, and pub date and uses them to create a new Item object 
			@items << item #each new Item object is stored in the @items array 
		end 
	end 

	def compare_pubdate(contents)
		@items.each do |item|
			if item.pub_date > Time.parse(contents) #iterates through @items array and compares pubdate to last tweet time, if the pub date is newer than the last tweet it tweets that item
				tweet(item)
			else 
				puts "***************** TO OLD ************************"
			end 
		end 
	end 

	def tweet(item) 
		tweet_time = Time.now.utc			
		puts "\nTitle: #{item.title}"
		puts "URL: #{item.url}"
		puts "Pub Date: #{item.pub_date}"
		File.open(@file,"w") {|f| f.puts(tweet_time)} #stores the time of the last tweet so it can be accessed later
	end 

	def items_to_tweet 
		tweet_time = 0 #variable to store when last tweet went out

		if !File.exists?(@file) || File.zero?(@file)
			puts "File empty or doesn't exist"
			@items.each do |item|
				tweet(item)
			end 
		else
			contents = File.open(@file, 'r') {|f| f.read}
			puts "Reading from file:"
			puts contents
			# Time.parse(contents) throws an error --> tweet
			#else 
			compare_pubdate(contents) 
		end 
		 	 

		#if no file 			-->			tweet & create file & write tweet time to file  
		#if file is Empty 		--> 		tweet & write tweet time to it 
		#if file is not Empty 	--> 		read contents, react, and write tweet time to file 







		# if !File.zero?(file) #checks that file is not empty 
		# 	puts "********Not Empty***********"
		# 	contents = File.open(file, "w+") {|f| f.read} #if file is not empty it reads it
		# 	@items.each do |item|
		# 		if item.pub_date > Time.parse(contents) #iterates through @items array and compares pubdate to last tweet time, if the pub date is newer than the last tweet it tweets that item
		# 			tweet_time = Time.now.utc			
		# 			puts "\nTitle: #{item.title}"
		# 			puts "URL: #{item.url}"
		# 			puts "Pub Date: #{item.pub_date}"
		# 		else 
		# 			puts "***************** TO OLD ************************"
		# 		end 
		# 	end 
		# else 
		# 	puts "********Zero***********"
		# 	@items.each do |item|
		# 		tweet_time = Time.now.utc
		# 		puts "\nTitle: #{item.title}"
		# 		puts "URL: #{item.url}"
		# 		puts "Pub Date: #{item.pub_date}"
		# 	end 
		# end 
		# puts tweet_time
		# File.open("last_tweet.txt","w") {|file| file.puts(tweet_time)} #stores the time of the last tweet so it can be accessed later
	end 




end 


if $0 == __FILE__

	feed = Feed.new("BOB.COM", 'https://gdata.youtube.com/feeds/api/users/goaztecscom/uploads')
	feed.items_to_tweet

end 