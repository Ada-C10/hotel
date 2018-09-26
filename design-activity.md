1.  What classes does each implementation include? Are the lists the same?
    Both implementations contain the same classes: CartEntry, ShoppingCart, Order

2.  Write down a sentence to describe each class.
    Implementation A:
    CartEntry contains the unit price and quantity of an entry.
    ShoppingCart contains a list of each entry.
    Order calculates the price of each entry, sums up all entries,
    and calculates the sales tax to provide the total cost of a shopping cart.

    Implementation B:
    CartEntry contains the unit price, quantity, and calculated price of an entry.
    ShoppingCart contains a list of each entry and sums up the price of each entry in the cart.
    Order retrieves the shopping cart subtotal and calculates the sales tax to provide the total cost.

3.  How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
    Implementation A:
    CartEntry > ShoppingCart (many to one)
    CartEntry > Order (many to one)
    ShoppingCart > Order (one to one)

    Implementation B:
    CartEntry > ShoppingCart (many to one)
    CartEntry > Order (none)
    ShoppingCart > Order (one to one)

4.  What data does each class store? How (if at all) does this differ between the two implementations?
    Both implementations store the same data in each class:
    CartEntry - unit_price, quantity
    ShoppingCart - entries
    Order - cart

5.  What methods does each class have? How (if at all) does this differ between the two implementations?
    Implementation A:
    CartEntry - none
    ShoppingCart - none
    Order - total_price

    Implementation B:
    CartEntry - price
    ShoppingCart - price
    Order - total_price

    Implementation A derives total_price with a dependency on CartEntry and ShoppingCart.
    Implementation B calculates the price at each class, allowing Order to depend on just one class (ShoppingCart) to calculate the total_price.

6.  Consider the Order#total_price method. In each implementation:
    Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
      Implementation A - not delegated to "lower level" classes, retained in Order
      Implementation B - delegated to "lower level" classes ShoppingCart and CartEntry
    Does total_price directly manipulate the instance variables of other classes?
      Implementation A - yes
      Implementation B - no

7.  If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
    CartEntry would need a specified price based on whether the quantity meets the bulk criteria. With this change, Implementation B would be easier to modify.

8.  Which implementation better adheres to the single responsibility principle?
    Implementation B.

9.  Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
    Implementation B.
