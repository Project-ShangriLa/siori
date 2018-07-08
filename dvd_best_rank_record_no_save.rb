require 'amazon/ecs'
require './amazon_api_init.rb'
require "httpclient"

#bundle exec ruby dvd_best_rank_save_record.rb

File.open './conf/conf.json' do |file|
  conf = JSON.load(file.read)
end

range = 1..10

range.each do |page|

  res = nil;
  sleep 3
  begin
    res = Amazon::Ecs.item_search("", :item_page => page, :search_index => 'DVD', :sort => "salesrank", :country => "jp", :BrowseNode =>"2147354051" ,:response_group => 'ItemAttributes,SalesRank')
  rescue => e
    puts e.to_s
    sleep 10
    retry
  end
  counter = 1
  sleep 3
  res.items.each do |item|
    best_seller_rank = (page - 1 ) * 10 + counter 
    
    puts item.get("ItemAttributes/Title")
    puts item.get("ASIN")
    puts best_seller_rank
    puts item.get("SalesRank")
    counter+=1

    param = {
      :title => item.get("ItemAttributes/Title"),
      :asin => item.get("ASIN"),
      :best_seller_rank => best_seller_rank,
      :raw_rank => item.get("SalesRank")
    }

    p param

    #post_aas(url, param)
  end
  
  sleep 3
end