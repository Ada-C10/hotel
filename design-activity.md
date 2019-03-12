1. What class does each implementation include?
  Implementation A:
  - CartEntry
  - ShoppingCart
  - Order

  Implementation B:
  - CartEntry
  - ShoppingCart
  - Order

  Each Implementation contains the same classes

2. Write down a sentence to describe each class:
  Implementation A:
  - CartEntry: characterized by a unit price and quantity. Contains state but not behavior.
  - ShoppingCart: characterized by an empty array of entries. Contains state but not behavior.
  - Order: A new instance of shopping cart is created and total price is calculated based off sales tax, unit price and quantity from Shopping cart entries.  

  Implementation B:
  - CartEntry: With unit price and quantity as state, it calculates price.
  - ShoppingCart: with entries given it gives total sum from each entry.  
  - Order: a new shopping cart is instantiated and total price is calculated with sales tax.

3. How do the classes relate to each other?
  - CartEntry's quantity and unit price are stored in the @entries array in the ShoppingCart class. An instance of ShoppingCart is then created in Order class and is then used to generate total price.

4. What data does each class store? How (if at all) does this differ between the two implementations?
  - CartEntry: quantity and unit price
  - ShoppingCart: entries array
  - Order: total price

  In implementation B, both CartEntry and ShoppingCart also store a price component.

5. What methods does each class have? How (if at all) does this differ between the two implementations?
  Implementation A:
  - ShoppingCart, CartEntry, and Order all have initialize methods.  In addition Order has a total price method.

  Implementation B:
  - ShoppingCart, CartEntry, and order all have initialize methods.  In addition both CartEntry and ShoppingCart have price methods, and Order has a total_price method.   


6. Consider the Order#total_price method. In each implementation: (1) Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order? (2) Does total_price directly manipulate the instance variables of other classes?
  - In implementation A, logic to compute price is not given to lower level classes, but it is given to CartEntry and ShoppingCart in Implementation B.
  -In Implementation A, the total_price directly manipulates the instance variables of ShoppingCart and CartEntry.  In Implementation B, it does not directly manipulate them, because those values used were already calculated in their individual classes.

7. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
  - Implementation B would be easier to modify because price is getting calculated directly in the CartEntry class instead of pulling it into the order class and calculating price from there.

8. Which implementation better adheres to the single responsibility principle?
 - Implementation B. Total price in implementation A is doing too much, where it could be easily divided and behavior given to the "lower classes", CartEntry, and ShoppingCart to simplify the process.

9. Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
 - Implementation B.  If modification were made to ShoppingCart and Entry it would take a lot more time and effort to fix Implementation A then B, whereas implementation B allows for easier change.

________________________________________________________________________________
Based on my hotel project, it looks like the admin class is taking on too many responsibilities. It's responsibility is to manage hotel reservations - which it does, but it was originally calculating reservation cost, when that responsibility could be given to the reservation class.  Now the "lower" reservation classes have a behavior to go along with their state.
