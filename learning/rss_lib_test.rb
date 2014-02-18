require 'rss'
require 'open-uri'
require 'ap'

url = 'https://gdata.youtube.com/feeds/api/users/goaztecscom/uploads'
#url = 'http://gdata.youtube.com/feeds/base/users/goaztecscom/uploads?alt=rss&amp;v=2&amp;orderby=published&amp;client=ytapi-youtube-profile'

#url = 'http://www.utsandiego.com/rss/headlines/sports/sdsu-aztecs/'
open(url) do |rss|
  feed = RSS::Parser.parse(rss)

  # p feed.feed_type

  ap feed.items.first.link.href
  # feed.entries.each do |item|
  #   pp item
  #   # p item.link.content
  # end
end




  # list.entries.each do |vid|
  # 	p vid.class
  # end 
  # p list.author.name
  # p feed.author.name
  # puts "Title: #{feed.channel.title}"
  # feed.items.each do |item|
  #   puts "Item: #{item.title}"
  #   puts "Item description: #{item.description}"
  # end




  # puts feed.channel.title
  # feed.items.each do |item|
  #   puts "Item: #{item.title}"
  #   puts "Item description: #{item.description}"
  # end
# end

