We want to build a simplified trade engine for exchanging bitcoins with euros

We have:
  - users which have bitcoins (recorded in btc_balance) and euros (recorded in eur_balance)
  - queued_orders which are created by the users and contain
    - a direction (buy or sell)
    - a btc_amount (which will always be 1 to simplify the algorithm)
    - a price in euros per bitcoins


the aim of the matching engine is to process the queued orders one by one.
two orders match when:
  - their direction are different
  - if the price of both exactly match

when two orders match, the engine should execute both orders and update user balances:
  - their state change to executed
  - the seller btc_balance is decreased by the orders btc_amount
  - the seller eur_balance is increased by btc_amount * price
  - the buyer btc_balance is increased by the orders btc_amount
  - the buyer eur_balance is decreased by btc_amount * price


complete the main.rb file to produce the output.json from the data.json