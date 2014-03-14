require_relative 'feed'

class FeedList
	attr_accessor :file
	attr_reader :feeds

	def initialize(file = 'feeds.txt') # sets file to save feeds to, sets @feed array, and calls the list method 
		@file = file 
		@feeds = {}
		
	end 

	def add # takes a feed from the user and writes it to the file 
		puts "Add feed:"
		puts 'Feed Name >>'
		name = gets.chomp
		puts 'Feed URL >>'
		url = gets.chomp

		File.open @file, 'a' do |f|
			f.puts "#{name},#{url}"
		end 
	end

	def get_feeds #gets the feeds from the file and puts them in the @feeds array so they can be used by the .edit and .delete methods
		file = File.open(@file)
		file.readlines.each do |line|
			name, url = line.split(",")
			@feeds[name] = url
		end
	end 

	def write_feeds #writes the @feeds array to the file so .edit and .delete can write the @feeds array they've changed to the file 
		File.open @file, 'w' do |f|
			@feeds.each {|k,v| f.puts "#{k},#{v}"}
		end
	end 

	def edit(name) #takes a file name from the user and then checks if that exists in the @feeds array. 
		get_feeds  #If it does it gets the id and asks the user what they want to change the name to and then changes that index to the new name.
				   #From here it calls the write_feeds method and writes the new array to the file 
		if @feeds.has_key?(name)
			@feeds.delete(name)
			puts "New Name >>"
			new_name = gets.chomp
			puts 'New URL >>'
			new_url = gets.chomp
			@feeds[new_name] = new_url 
			puts "Feed updated!"
			write_feeds
		else 
			puts "There is no feed with that name."
		end 
	end 


	def delete(name) #works almost the same as the .edit method but instead of changing the feed name it deletes it
		get_feeds

		if @feeds.has_key?(name)
			puts "Are you sure you want to delete this feed? (yes OR no)"
			answer = gets.chomp.downcase
			if answer == 'yes'
				@feeds.delete(name) #deletes that 
				puts "#{name} deleted."
				write_feeds
			else 
				puts "Ok won't delete that feed."
			end 
		else 
			puts "There is no feed with that name."
		end 
	end 

	def no_feeds
		puts "You have no feeds.  Please add some feeds."
		add
	end 

	def list #if the feeds.txt file is empty it asks for feeds, if not it lists (puts) the feeds from the file 
		if File.exists?(@file)

			if File.size?(@file)
				puts "List of feeds from file #{@file}:" 
				get_feeds
				@feeds.each do |k, v|
					puts "#{k.ljust(50,'.')}#{v}"
				end 
			else
				no_feeds 
			end 

		else 
			no_feeds
		end  
	end 


end 


if $0 == __FILE__
	feed_list = FeedList.new
end





