require 'amazon/ecs'
require './amazon_api_init.rb'

# API呼び出し
# B00FB56XPA
res = Amazon::Ecs.item_lookup(ARGV[0], :response_group => 'Small, ItemAttributes, Images, SalesRank', :country => 'jp')

# 返ってきたXMLを表示（res.doc.to_sでも多分OK）
puts res.marshal_dump