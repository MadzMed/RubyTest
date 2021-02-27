require_relative 'order'

class QueuedOrder
  attr_reader :id, :user_id, :direction, :btc_amount, :price
  @@auto_increment = 1

  def initialize(user_id, direction, btc_amount, price)
    @id = @@auto_increment
    @@auto_increment += 1
    @user_id = user_id
    @direction = direction
    @btc_amount = btc_amount
    @price = price
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end

  def self.find_all(direction)
    orders = []
    all.each do |order|
        orders << order if order.direction == direction
    end
    orders
  end

  def self.count
    all.count
  end

  def self.match_orders
    matches = []
    sell_orders = find_all('sell')
    buy_orders = find_all('buy')
    buy_orders.each do |buy_order|
      sell_orders.each do |sell_order|
        if sell_order.btc_amount == buy_order.btc_amount && sell_order.price == buy_order.price
          matches << Order.new(buy_order.user_id, buy_order.direction, buy_order.btc_amount, buy_order.price)
          matches << Order.new(sell_order.user_id, sell_order.direction, sell_order.btc_amount, sell_order.price)
          # update_users(buy_order, sell_order)
        end
      end
    end
    matches
  end

  def self.update_users(buy, sell)
    User.find(buy.user_id).btc_balance += buy.btc_amount
    User.find(buy.user_id).eur_balance -= buy.btc_amount * price
    User.find(sell.user_id).btc_balance -= sell.btc_amount
    User.find(sell.user_id).eur_balance += sell.btc_amount * price
  end
end

