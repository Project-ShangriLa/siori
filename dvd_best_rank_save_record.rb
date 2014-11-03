require 'amazon/ecs'
require './amazon_api_init.rb'
require "httpclient"

#bundle exec ruby dvd_best_rank_save_record.rb

File.open './conf/conf.json' do |file|
  conf = JSON.load(file.read)
  @aas_conf = conf["anime_api_server"]
end

url = "http://" + @aas_conf["url"] + ":" + @aas_conf["port"].to_s + "/" + @aas_conf["rank"] + ".json"
get_time = Time.now


def post_aas(url, param)
  http_client = HTTPClient.new
  http_client.post_content(URI.parse(url), param.to_json, 'Content-Type' => 'application/json')
end

range = 1..10

range.each do |page|

  res = nil;

  begin
    res = Amazon::Ecs.item_search("", :item_page => page, :search_index => 'DVD', :sort => "salesrank", :country => "jp", :BrowseNode =>"2147354051" ,:response_group => 'ItemAttributes,SalesRank')
  rescue => e
    puts e.to_s
    sleep 10
    retry
  end
  counter = 1
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
      :raw_rank => item.get("SalesRank"),
      :get_time => get_time
    }
    post_aas(url, param)
  end
  
  sleep 1
end