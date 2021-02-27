# Exchange for BTC

## Class User

### initialize

define a simple user with bitcoin balance and euro balance, project isn't connect to db, however
I will create a similar behaviour using an id for users, using class variable to incremente automatically
the value of the id. (I don't create verification methods to check uniqueness of the id, in Rails there is active record)

### open_order

User can open an order with a direction 'sell' or 'buy', Error raise if some conditions are false:
  - if user want to sell more btc than he have
  - if user want to buy more btc than he can with his euro balance
  - if direction doesn't match 'sell' or 'buy'

### method_missing

Allow us to have two new function in the class (meta function) named:
 - sell_order
 - buy_order

## Queued Order

### class methods

  -all: get all queued order instances
  -count: count all queued order instances

## match_orders

  check the queued order that match with his opposite.
  PS: have to complete method to avoid repetitive match ( if an order is match once, he can't be match with other order)



NB: I forgot to adapt the new balance for users, however, if i had time:
I would create a class method for User to find a specific user with his id, then modify the value of the balance
