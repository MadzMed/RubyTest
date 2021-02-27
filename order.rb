class Order
  attr_reader :id, :user_id, :direction, :btc_amount, :price
  @@auto_increment = 1

  def initialize(user_id, direction, btc_amount, price)
    @id = @@auto_increment
    @@auto_increment += 1
    @user_id = user_id
    @direction = direction
    @btc_amount = btc_amount
    @price = price
    @state = 'execute'
  end

  def as_json(options = {})
    {
      id: @id,
      user_id: @user_id,
      direction: @direction,
      btc_amount: @btc_amount,
      price: @price,
      state: @state
    }
  end

   def to_json(*options)
     as_json(*options).to_json(*options)
   end
end
