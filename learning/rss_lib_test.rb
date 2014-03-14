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
    @recency = 80000
    @tweet_time = 0#time the tweet is sent out 


    @tweet_length = Proc.new{ #proc to check tweet length
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
      @std_pub_date = Time.parse(item.pubDate.to_s).utc #takes the item's pubdate, converts to a string and passes it to the .parse method and then calls the .utc method
      @tweet = "#{title} #{link}"                       #this standardizes the feed pubdates 
      @tweet_length.call 
      if @std_pub_date > (Time.now.utc - @recency) 
        tweet
        @tweet_time = Time.now.utc
        File.open("tweet_time.txt", "a") {|file| file.puts(@tweet_time)}
      else
        puts "-------------TO OLD!!!-----------------"
      end 
      
    end 
  end 


  def atom_parser(atom)
    atom.items.each do |item| 
      title = item.title.content
      link = item.link.href
      @std_pub_date = Time.parse(item.published.content.to_s).utc
      @tweet = "#{title} #{link}"
      @tweet_length.call
      if @std_pub_date > (Time.now.utc - @recency) 
        tweet
        @tweet_time = Time.now.utc
        File.open("tweet_time.txt", "a") {|file| file.puts(@tweet_time)}
      else
        puts "-------------TO OLD!!!-----------------"
      end 

    end 
  end 

  def tweet
    puts @tweet
  end 

  #tweet out feeds that are >= 3 weeeks old & store the time of the last tweet to a file tweet_time.txt
  #run it again with no if statement for pubdate and compare the pub dates of the feeds with the date of the last tweet
      #if the pub date is more recent then the tweet time tweet the feed


      #need to create
          #for each tweet - store Time.now.utc and write it to a file tweet_time.txt 
          #when you rerun the program loop through the feeds and compare the @std_put_date to @tweet_time


      #eventually need to make a tweet its own class or a struct 


end 


parser = FeedParser.new('https://gdata.youtube.com/feeds/api/users/goaztecscom/uploads', 'http://www.utsandiego.com/rss/headlines/sports/sdsu-aztecs/')
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

