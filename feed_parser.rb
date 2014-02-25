require 'rss'
require 'open-uri'
require 'twitter'
require 'yaml'

class FeedParser 

	def initialize(*feeds)
		@feeds = feeds 
		@tweet = ""
		@pub_date = ""
		@tweet_length = Proc.new{ 
			if @tweet.length > 140
				next 
			else 
				tweeter(@tweet)
				puts "tweeted"

				sleep(15)
			end 
		}

		config = YAML.load_file('config.yml')

		@client = Twitter::REST::Client.new({
  			consumer_key: config['consumer_key'],
  			consumer_secret: config['consumer_secret'],
  			access_token: config['access_token'],
  			access_token_secret: config['access_token_secret']
		})
		
	end 

	def run 
		feed_sorter
	end 

# method that sorts feeds
	def feed_sorter
		@feeds.each do |url|
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
	end 

	def rss_parser(rss)
		rss.items.each do |item| 
			title = item.title
			link = item.link
			@tweet = "#{title} #{link}"
			@tweet_length.call 
			
		end 
	end 


	def atom_parser(atom)
		atom.items.each do |item| 
			title = item.title.content
			link = item.link.href
			@tweet = "#{title} #{link}"
			@tweet_length.call

		end 
	end 

	def tweeter(tweet)
		@client.update(tweet)
	end 
end 


parser = FeedParser.new('https://gdata.youtube.com/feeds/api/users/goaztecscom/uploads', 'http://www.utsandiego.com/rss/headlines/sports/sdsu-aztecs/')
parser.run
