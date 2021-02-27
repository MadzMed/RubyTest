require 'json'
require_relative 'user'
require_relative 'queued_order'
require_relative 'order'

data = JSON.parse(File.open('data.json').read)

# init users
users = []
data['users'].each do |user|
  users << User.new(user['btc_balance'], user['eur_balance'])
end

queued_orders = []
data['queued_orders'].each do |order|
  queued_orders << QueuedOrder.new(order['user_id'], order['direction'], order['btc_amount'], order['price'])
end
matches = QueuedOrder.match_orders

user_list = []
users.each do |user|
  user_list << user.as_json
end

orders_list = []
matches.each do |order|
  orders_list << order.as_json
end
json_final = { users: user_list, queued_orders: [], orders: orders_list}
output_file = File.open('output_test.json', 'w')
output_file.write(json_final)
