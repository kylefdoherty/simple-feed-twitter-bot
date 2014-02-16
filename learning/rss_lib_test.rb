require 'rss'
require 'open-uri'


url = 'http://gdata.youtube.com/feeds/api/users/goaztecscom/uploads'
# url = 'http://www.utsandiego.com/rss/headlines/sports/sdsu-aztecs/'
open(url) do |rss|
  list = RSS::Parser.parse(rss)

  list.entries.each do |vid|
  	p vid.class
  end 
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
end

