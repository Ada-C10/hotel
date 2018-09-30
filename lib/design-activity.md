In Implementation A classes:
CartEntry
  initialize two instance variables unit_price & quantity.
ShoppingCart
  initialize an instance variables with an empty array.
Order
  instantiate a new instance of an entry from the Shopping Cart class with instance variable cart.
  SALES_TAX is a constant  
Total_Price
  calculating the total price of each item in the shopping cart.

Implementation B classes
CartEntry
   creates a method to calculate the price of all the same items per quantity.
ShoppingCart
  Adds the sum of all items purchased.
Order
  instantiate an instance of ShoppingCart and calculates the total of the order with sales tax.

I think it is better to have total_price in order because if a calculation changed in shopping cart it would automatically be reflected in order.

I don't believe it does manipulate the instance variable in other classes.

If we were to add a bulk option I would add it to the price method in CartEntry as a conditional.

I think Implementation B has a single responsibility because Implementation A has some classes with zero responsibility. 
