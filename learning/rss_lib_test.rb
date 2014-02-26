require 'rss'
require 'open-uri'
require 'twitter'
require 'yaml'
require 'time'


class FeedParser 

  def initialize(*feeds)
    @feeds = feeds 
    @tweet = ""
    @std_pub_date = ""
    @recency = 43200




    @tweet_length = Proc.new{ 
      if @tweet.length > 140
        next 
      else 
        @tweet
      end 
    }
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
      @std_pub_date = Time.parse(item.pubDate.to_s).utc
      @tweet = "#{title} #{link}"
      @tweet_length.call 
      tweet_recency
      
    end 
  end 


  def atom_parser(atom)
    atom.items.each do |item| 
      title = item.title.content
      link = item.link.href
      @std_pub_date = Time.parse(item.published.content.to_s).utc
      @tweet = "#{title} #{link}"
      @tweet_length.call
      tweet_recency

    end 
  end 

  def tweet_recency
    if @std_pub_date > (Time.now.utc - @recency) 
      puts @tweet
    else
      puts "-------------TO OLD!!!-----------------"
    end 

  end 


end 


parser = FeedParser.new('http://widget.stagram.com/rss/n/goaztecs/','https://gdata.youtube.com/feeds/api/users/goaztecscom/uploads', 'http://www.utsandiego.com/rss/headlines/sports/sdsu-aztecs/')
parser.run



















# url = 'https://gdata.youtube.com/feeds/api/users/goaztecscom/uploads'
# #url = 'http://gdata.youtube.com/feeds/base/users/goaztecscom/uploads?alt=rss&amp;v=2&amp;orderby=published&amp;client=ytapi-youtube-profile'

# #url = 'http://www.utsandiego.com/rss/headlines/sports/sdsu-aztecs/'
# open(url) do |rss|
#   feed = RSS::Parser.parse(rss)

#   # p feed.feed_type

#   ap feed.items.first.link.href
#   # feed.entries.each do |item|
#   #   pp item
#   #   # p item.link.content
#   # end
# end




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

