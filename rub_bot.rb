require_relative 'feed.rb'

class CommandLineInterface #allows user to interact with feed.rb to list, add, edit, and delete 

	def initialize 
		@feeds = Feed.new
		take_commands
	end 

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
				@feeds.list
			when "-add"
				@feeds.add
			when "-edit"
				puts "feed name:"
				name = gets.chomp
				@feeds.edit(name)
			when "-delete"
				puts "feed name:"
				name = gets.chomp
				@feeds.delete(name)
			when "-tweet"
				puts "get feeds #{@feeds.get_feeds}"
				puts "the class #{@feeds.get_feeds.class}"
			when "-quit"
				exit 
			else 
				p 'not a valid command'
			end 
		end 
		take_commands
	end 
	 

end

cli = CommandLineInterface.new	