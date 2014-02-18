require 'simple-rss'
require 'open-uri'


rss = SimpleRSS.parse open('https://gdata.youtube.com/feeds/api/users/goaztecscom/uploads')

rss.feed_type
# rss.entries.each do |entry|
# 	puts entry.title
# end 

# #feed getter
# feeds = ['http://gdata.youtube.com/feeds/api/users/goaztecscom/uploads', 'http://www.utsandiego.com/rss/headlines/sports/sdsu-aztecs/']

# #feed sorter 
# feeds.each do |feed|
# 	case 
# 	when feed.include?('feed')
		 
# 	#when feed has 'feed' in it it's an atom feed
# 	#when feed has 'rss' in it it's an rss feed
# 	#else invalid feed
# end 


# # rss = SimpleRSS.parse open('http://gdata.youtube.com/feeds/api/users/goaztecscom/uploads')
# rss = SimpleRSS.parse open('http://www.utsandiego.com/rss/headlines/sports/sdsu-aztecs/')


# #control flow for type of feed going to need to pass the feeds to this method or class
# case feed_type 
# when == "rss"
# 	rss.channel.items.each do |story|
# 		tweet = "#{story.title} #{story.link}"
# 		puts tweet.length
# 	end 
# when == "atom"
# 	rss.entries.each do |vid|
# 		title = vid.media_title.split('-')
# 		link = vid.link

# 		title.delete_at(-1)
# 		if title.length == 2
# 			message = "#{title[0].strip} #{title[1].strip}"
# 			tweet = "#{message} #{link}" 
# 			puts tweet.length
# 		else 
# 		 	message = "#{title[0].strip}"
# 			tweet = "#{message} #{link}"
# 			puts tweet.length
# 		end 
# 	end 
# end 



