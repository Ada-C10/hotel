1. What classes does each implementation include? Are the lists the same?
implementation a: CartEntry, ShoppingCart, Order.
implementation b: CartEntry, ShoppingCart,Order.
Yes, the lists are the same.

2. Write down a sentence to describe each class.
implementation a:
  CartEntry- initialize cart with unit_price and quantity as local variables.
  ShoppingCart- initialize cart with entries as local variable containing an empty array.
  Order- define SALES_TAX, initialize order with a new instance of @cart, method for calculating the prices
          by iterating through @cart entries, calling unit_price on the entry, and returning the total including sales tax.
implementation b:
  CartEntry- initialize cart with unit_price and quantity as local variables,
              and a method for calling price.
  ShoppingCart- initialize cart as a local variable containing an empty array.
  Order- define SALES_TAX, define subtotal by calling price on @cart, and returning the total including sales tax.

3. How do the classes relate to each other?


4. What data does each class store? How (if at all) does this differ between the two implementations?



5. What methods does each class have? How (if at all) does this differ between the two implementations?


6. Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
Does total_price directly manipulate the instance variables of other classes?


7. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

8. Which implementation better adheres to the single responsibility principle?


** Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled? implementation a
