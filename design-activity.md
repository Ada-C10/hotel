What classes does each implementation include? Are the lists the same?

  Each implementation contains the same three classes (CartEntry, ShoppingCart, and Order) however they are differ in what they contain.


Write down a sentence to describe each class.

  CartEntry keeps track of unit prices and quantities of items in a shopping cart.
  ShoppingCart is a collection of CartEntries.
  Order calculates the total cost of all items in a shopping cart including tax.


How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

  A ShoppingCart instance collects instances CartEntry items. Order calculates the total price of all CartEntry items in a ShoppingCart instance including tax.


What data does each class store? How (if at all) does this differ between the two implementations?
  CartEntry stores @unit_price and @quantity relating to a cart entry.

  ShoppingCart stores @entries, instances of CartEntry items in an array.

  Order stores @cart, an instance of ShoppingCart.
  The data stored doesn't differ between the two implementations.

What methods does each class have? How (if at all) does this differ between the two implementations?

  Implementation A only has one method, total_price, in the Order class. Implementatin B has this method, as well as price methods in the CartEntry and ShoppingCart classes.


Consider the Order#total_price method. In each implementation:
  Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

  In implementation A, the logic to compute price is total contained within the total_price method.  In implementation B, part of the logic to compute price is pushed down into the lower level classes of CartEntry and ShoppingCart.


  Does total_price directly manipulate the instance variables of other classes?

    In implementation A total_price manipulates the variables unit_price and quantity of the CartEntry class. In implementation B, total_price does not use the instance variables of any other classes, it calculates price using methods of the other classes.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

  Bulk purchases would require a change to the expression that calculates price. It would be easier to modify implementation B because there is only one class in which changes would need to be made to the instance variables or price calculation to account for bulk purchases, whereas in implementation A you would need to change both the CartEntry class and the Order class to calculate bulk purchases correctly.
  

Which implementation better adheres to the single responsibility principle?

  Implementation B.


Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

  Implementation B is more loosely coupled. Each class in B refers to methods of other classes in calculating price, where the Order class of A uses instance variables of another class to calculate price.
