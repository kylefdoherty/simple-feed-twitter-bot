require_relative 'feed_list'
require_relative 'feed'

class BotInterface #allows user to interact with feed.rb to list, add, edit, and delete 

	def initialize 
		@list_of_feeds = FeedList.new
		take_commands
	end 

	# def tweet
	# 	feed_list = @feeds.feeds
	# 	feed_list.each do |k,v|
	# 		new_feed = Feed.new(k,v)
	# 		puts "******#{k} Feed Items *******"
	# 		new_feed.items
	# 	end 
	# end 

	def take_commands
		puts "What do you want to do?  To see list of commands enter -commands"
		until false 
		response = gets.chomp.downcase
		parse_response(response)
		end 
	end 

	def parse_response(response)
		if response == "-commands"
			puts "-list	  - list your feeds"
			puts "-add	  - add a new feed"
			puts "-edit	  - edit an existing feed"
			puts "-delete - delete an existing feed"
			puts "-tweet  - tweets out the feeds" 
			puts "-quit  - quit this program"

		else 
			case response 
			when "-list"
				@list_of_feeds.list
			when "-add"
				@list_of_feeds.add
			when "-edit"
				puts "feed name:"
				name = gets.chomp
				@list_of_feeds.edit(name)
			when "-delete"
				puts "feed name:"
				name = gets.chomp
				@list_of_feeds.delete(name)
			when "-tweet"
				@list_of_feeds.generate_feeds
				
			when "-quit"
				exit 
			else 
				p 'not a valid command'
			end 
		end 
		take_commands
	end 
	 

end



cli = BotInterface.new	