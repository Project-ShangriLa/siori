require 'amazon/ecs'
require './amazon_api_init.rb'

#bundle exec ruby dvd_ranking_status.rb "SHIROBAKO"

res = Amazon::Ecs.item_search(ARGV[0], :item_page => 1, :search_index => 'DVD', :country => "jp", :response_group => 'ItemAttributes,SalesRank')

sleep(3)

res.items.each do |item|
  puts item.get("ASIN")
  puts item.get("ItemAttributes/Title")
  puts item.get("SalesRank")
end