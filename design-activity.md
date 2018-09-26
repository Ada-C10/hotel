1. What classes does each implementation include? Are the lists the same?

  A. CartEntry, ShoppingCart, Order
  B. CartEntry, ShoppingCart, Order

  Yes, both lists are the same

2. Write down a sentence to describe each class.

  A.  CartEntry: Responsible for the state of the unit_price and quantity.
      ShoppingCart: Responsible for the state of 'entries.'
      Order: Responsible for instantiating a new instance of ShoppingCart and has a behavior which sums each element within the 'entries' array.
  B.  CartEntry: Responsible for the state of the unit_price and quantity and has a behavior that calculates the price of a single cart entry.
      ShoppingCart: Responsible for the state of 'entries' and has a behavior that sums the price of each cart entry within the 'entries' array.
      Order: Responsible for instantiating a new instance of ShoppingCart and has a behavior that calculates the total_price of an instance of Order.

3. How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

  A. The CartEntry and ShoppingCart only contain attributes. The class Order will call on the class ShoppingCart and instantiate a new ShoppingCart. Order contains a method that calculates the total_price by first accessing the ShoppingCart attribute 'entries' and each entry must then access the attributes of unit_price and quantity within the class CartEntry.
  B.  The class CartEntry contains a method that will calculate price using the instance variables unit_price and quantity. The class ShoppingCart contains a method price that iterates through the instance variable 'entries' which will call on the method 'price' from the class CartEntry. The class Order contains a method 'total_price' which will call on the method 'price' from the ShoppingCart class.

4. What data does each class store? How (if at all) does this differ between the two implementations?

  A.  CartEntry: instance variables 'unit_price' and 'quantity'
      ShoppingCart: instance variable 'entries'
      Order: instance variable 'cart'
  B.  CartEntry: instance variables 'unit_price' and 'quantity'
      ShoppingCart: instance variable 'entries'
      Order: instance variable 'cart'
  Differences: The classes for both implementations contain the same data.

5. What methods does each class have? How (if at all) does this differ between the two implementations?

  A.  CartEntry: no methods
      ShoppingCart: no methods
      Order: method total_price which calculates total_price of all entries within an instance of ShoppingCart
  B.  CartEntry: method price which calculates the price of each entry
      ShoppingCart: method price which calculates the sum of all entries within the instance variable 'entries'
      Order: method total_price which calculates the total_price by calling on the methods CartEntry#price and ShoppingCart#price
      Differences: With both implementations, each class contains the same attributes. The difference is that with Implementation A, CartEntry and ShoppingCart only contain attributes while Order contains all the logic of calculations. With Implementation B, CartEntry contains a method that calculates the price for each entry, ShoppingCart contains a method that calculates the summed price of all entries within each instance of 'entries' and Order contains a method that calculates the total_price of each instance of ShoppingCart

***Consider the Order#total_price method. In each implementation:***
6. Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

  A. Order retains all logic to compute price.
  B. Price is delegated to ShoppingCart and CartEntry, while Order calculates total_price

7. Does total_price directly manipulate the instance variables of other classes?

  A. Order#total_price accesses 'entries' from ShoppingCart, which then must access 'unit_price and 'quantity' from CartEntry in order to calculate total_price
  B. Order#total_price accesses ShoppingCart#price, which accesses CartEntry#price

8. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

  Depends how values are assigned to the instance variables 'unit_price' and 'quantity.' If values are just hard coded, no changes need to be made either implementation. If another instance variable such as 'discount' were to be included to the class CartEntry, then Implementation B is easier to modify as each CartEntry will complete its own price calculation; whereas with Implementation A, the calculation becomes a lot more complicated as Order is responsible for all price calculations.

9. Which implementation better adheres to the single responsibility principle?

  Implementation B, as each class calculates it's 'own' price

10. Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

  Implementation B
