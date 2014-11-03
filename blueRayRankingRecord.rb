require 'amazon/ecs'
require './amazon_api_init.rb'
require "httpclient"

File.open './conf/conf.json' do |file|
  conf = JSON.load(file.read)
  @aas_conf = conf["anime_api_server"]
end

base_url = "http://" + @aas_conf["url"] + ":" + @aas_conf["port"].to_s + "/" + @aas_conf["base"] + ".json?cours_id=4"
post_url = "http://" + @aas_conf["url"] + ":" + @aas_conf["port"].to_s + "/" + @aas_conf["raw_rank"] + ".json"
get_time = Time.now


def post_aas(url, param)
  http_client = HTTPClient.new
  http_client.post_content(URI.parse(url), param.to_json, 'Content-Type' => 'application/json')
end

result = Net::HTTP.get(URI.parse(base_url))
base_list = JSON.load(result)

base_list.each do |base|
  target = base["title"] + " Blu"

res = nil
begin  
  res = Amazon::Ecs.item_search(target, :item_page => 1, :search_index => 'DVD', :country => "jp", :response_group => 'ItemAttributes,SalesRank')
rescue => e
  puts e.to_s
  sleep 5
  retry
end

  res.items.each do |item|
    puts item.get("ASIN")
    puts item.get("ItemAttributes/Title")
    puts item.get("SalesRank")
    param = {
      :title => item.get("ItemAttributes/Title"),
      :asin => item.get("ASIN"),
      :rank => item.get("SalesRank"),
      :get_time => get_time
    }
    post_aas(post_url, param)
  end
  sleep 5
end
