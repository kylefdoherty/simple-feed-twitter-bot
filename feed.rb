require 'yaml'
require 'ap'

#class that stores feeds
class Feed
	attr_accessor :file

	def initialize(file = 'feeds.txt')
		@file = file
		@feeds = []
		list
	end 

	def create
		puts "Add feed"
		puts '>>'
		new_feed = gets.chomp
		File.open @file, 'a' do |f|
			f.puts new_feed
		end 
		puts "added the feed #{new_feed}"
	end

	def get_feeds
		File.open(@file).readlines.each do |f|
			@feeds << f.strip 
		end 
	end 

	def write_feeds
		File.open @file, 'w' do |f|
			@feeds.each {|feed| f.puts(feed)}
		end
	end 

	def edit(name)
		get_feeds

		if @feeds.include?(name)
			index = @feeds.index(name)
			puts "What do you want to change #{name} to?"
			new_feed = gets.chomp
			@feeds[index] = new_feed
			write_feeds
		else 
			puts "no such file"
		end 
		list
	end 


	def delete(name)
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

	def list
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


feed1 = Feed.new
feed1.delete("feeds.com")



