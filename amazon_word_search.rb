require 'amazon/ecs'
require './amazon_api_init.rb'
#bundle exec ruby test_amazon_api2.rb 'ガンダム Blu'

res = Amazon::Ecs.item_search(ARGV[0], :item_page => 1, :country => "jp")
# 返ってきたXMLを表示（res.doc.to_sでも多分OK）

res.items.each do |item|
  puts item.get_elements("./ASIN")
  puts item.get("ItemAttributes/Title")
end