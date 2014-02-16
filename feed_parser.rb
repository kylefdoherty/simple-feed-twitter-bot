require 'simple-rss'
require 'open-uri'
require 'twitter'
require 'pp'

class RssParser 

	def initialize(*feeds)
		@feeds = feeds 
		@sorted_feeds = {}
		@tweet = ''
		
		@client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = "fMsGPsxjkmi8htwq9wa8g"
		  config.consumer_secret     = "PeZSd8Uni7JmjJKYHYxDKIgkloLLiGFaxNkjuwcw4"
		  config.access_token        = "2347440661-zS5uDSpFff2PzHfziH0VIzjtK5FdvrvHGLQN3CD"
		  config.access_token_secret = "rVjaYKDOvgztzafwC1oIXwSVvZ9kD5C9UekByVbkLlOyd"
		end
	end 
		

	def run
		feed_sorter
		feed_parser
	end 

#method to sort if feeds are atom or rss feed
	def feed_sorter
		feed_num = 0 

		@feeds.each do |feed|
			feed_num +=1
			case 
			when feed.include?('feed')
				@sorted_feeds[feed_num] = [feed, 'atom']
			when feed.include?('rss')
				@sorted_feeds[feed_num] = [feed, 'rss']
			else invalid feed
			end 
		end 
	end 

#method to parse feed to retrieve the title and link, and to clean up youtube titles for the goaztecscom yoututbe titles.  later will need to change this but for now this is my only atom feed
	def feed_parser 

		@sorted_feeds.each do |k,v|

			case 
			when v[1] == "rss"
				rss = SimpleRSS.parse open(v[0])
				rss.channel.items.each do |story|
					@tweet = "#{story.title} #{story.link}"
					send_tweet
				sleep(30)
				end 
			when v[1] == "atom"
				rss = SimpleRSS.parse open(v[0])
				rss.entries.each do |vid|
					title = vid.media_title.split('-')
					link = vid.link

					title.delete_at(-1)
					if title.length == 2
						message = "#{title[0].strip} #{title[1].strip}"
						@tweet = "#{message} #{link}" 
						send_tweet
						
					else 
					 	message = "#{title[0].strip}"
						@tweet = "#{message} #{link}"
						send_tweet
					end 
					sleep(20)
				end 
			end
		end 

	end 

	def send_tweet
		@client.update(@tweet)
		puts "Sent tweet: #{@tweet}"
	end 

end 

parser = RssParser.new('http://gdata.youtube.com/feeds/api/users/goaztecscom/uploads', 'http://www.utsandiego.com/rss/headlines/sports/sdsu-aztecs/')
parser.run







