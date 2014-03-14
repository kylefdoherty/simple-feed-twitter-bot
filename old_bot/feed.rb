#class that stores feeds
class Feed
	attr_accessor :file

	def initialize(file = 'feeds.txt') # sets file to save feeds to, sets @feed array, and calls the list method 
		@file = file 
		@feeds = []
		
	end 

	def create # takes a feed from the user and writes it to the file 
		puts "Add feed"
		puts '>>'
		new_feed = gets.chomp
		File.open @file, 'a' do |f|
			f.puts new_feed
		end 
		puts "added the feed #{new_feed}"
	end

	def get_feeds #gets the feeds from the file and puts them in the @feeds array so they can be used by the .edit and .delete methods
		File.open(@file).readlines.each do |f|
			@feeds << f.strip 
		end 
	end 

	def write_feeds #writes the @feeds array to the file so .edit and .delete can write the @feeds array they've changed to the file 
		File.open @file, 'w' do |f|
			@feeds.each {|feed| f.puts(feed)}
		end
	end 

	def edit(name) #takes a file name from the user and then checks if that exists in the @feeds array. 
		get_feeds  #If it does it gets the id and asks the user what they want to change the name to and then changes that index to the new name.
				   #From here it calls the write_feeds method and writes the new array to the file 
		if @feeds.include?(name)
			index = @feeds.index(name)
			puts "What do you want to change #{name} to?"
			new_feed = gets.chomp
			@feeds[index] = new_feed
			write_feeds
		else 
			puts "no such feed"
		end 
		list
	end 


	def delete(name) #works almost the same as the .edit method but instead of changing the feed name it deletes it
		get_feeds

		if @feeds.include?(name) 
			index = @feeds.index(name)
			puts "Are you sure you want to delete #{name}?"
			puts "Enter 'yes' or 'no':"
			answer = gets.chomp.downcase
			if answer == "yes"
				@feeds.delete_if {|feed| feed == name}
				write_feeds
				puts "Feed #{name} has been deleted."
			else 
				puts "Ok I won't delete it then."
			end 
		else 
			puts "Sorry don't have that file."
		end 
	end 

	def list #if the feeds.txt file is empty it asks for feeds, if not it lists (puts) the feeds from the file 
		read_file = File.read @file
		if read_file.empty?
			puts "the file is empty please add some feeds"
			create
		else
			puts "here is the list of feeds from file #{@file}" 
			puts read_file
		end 
	end 


end 







