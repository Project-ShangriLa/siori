require 'amazon/ecs'
require 'json'

File.open './conf/conf.json' do |file|
  conf = JSON.load(file.read)
  @amazon_conf = conf["Amazon"]
end

Amazon::Ecs.options = {
  :associate_tag => @amazon_conf["associate_tag"],
  :AWS_access_key_id => @amazon_conf["AWS_access_key_id"], 
  :AWS_secret_key => @amazon_conf["AWS_secret_key"]
}