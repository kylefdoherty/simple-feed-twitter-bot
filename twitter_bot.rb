require 'twitter'
require_relative 'feed_parser'

class TwitterBot

	def initialize
		Twitter.configure do |config|
			config.consumer_key =
			config.consumer_secret =
			config.oath_token =
			config.oath_token_secret =
		end 
	end 

	def tweet
		Twitter.update()
	end 



end 