require_relative 'queued_order'

class User
  attr_reader :id, :btc_balance, :eur_balance
  @@auto_increment = 1

  def initialize(btc_balance, eur_balance)
    @eur_balance = eur_balance
    @btc_balance = btc_balance
    @id = @@auto_increment
    @@auto_increment += 1
  end

  def open_order(direction, btc_amount, price)
    throw 'InvalidDirectionError' unless direction == "sell" || direction == 'buy'
    if direction == "sell"
      throw 'InvalidValueError' unless btc_amount <= @btc_balance
    else
      throw 'InvalidAmountError' unless btc_amout * price <= eur_balance
    end
    QueuedOrder.new(direction, 30, 5, @id)
  end

  def method_missing(name, *args)
    str = name.to_s
    return super unless str =~ /^*_order/
    direction = str.split('_')[0]
    return open_order(direction, args[0], args[1])
  end

  def as_json(options = {})
    {
      id: @id,
      btc_balance: @btc_balance,
      eur_balance: @eur_balance
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end

  def self.find(id)
    all.each do |user|
      return user if user.id == id
    end
  end
end
