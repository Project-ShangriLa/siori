require 'amazon/ecs'
require './amazon_api_init.rb'
require "./grapics.rb"

res = Amazon::Ecs.item_search(ARGV[0], :item_page => 1, :search_index => 'DVD', :country => "jp", :sort => "orig-rel-date", :response_group => 'ItemAttributes,SalesRank')

BASE_POINT = 10000
graph_data = []
graph_label = {} 
label_counter = 0

res.items.each do |item|
  puts item.get("ASIN")
  puts item.get("ItemAttributes/Title")
  puts item.get("SalesRank")
  
  graph_data.push BASE_POINT - item.get("SalesRank").to_i
  graph_label[label_counter] = item.get("ItemAttributes/Title")[0,15]
  label_counter+=1
end

p graph_data
p graph_label

filename = draw_grahics(graph_data, graph_label, "AmazonRank" , Time.now)
puts filename