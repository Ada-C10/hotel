## Evaluating Responsibility

* What classes does each implementation include? Are the lists the same? | Each has the same classes, CartEntry, ShoppingCart, and Order, but the methods have been reorganized in the second implementation.
* Write down a sentence to describe each class. |
 * CartEntry handles an item added, taking in as parameters its unit price and quantity. It also calculates the price of that CartEntry instance.
 * ShoppingCart manages the list of entries and price of all entries combined.
 * Order stores the constant SALES_TAX and totals the sum of the ShoppingCart plus Sales tax.
* How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
 * Order totals the cost of the ShoppingCart which has a collection of instances of CartEntry.
* What data does each class store? How (if at all) does this differ between the two implementations?
 * CartEntry stores the instance variables unit_price and quantity, which are only used in CartEntry. In the second implementation, it does not have an attribute accessor.
 * ShoppingCart stores the instance variable entries which is a collection of CartEntry instances. In the second implementation, it does not have an attribute accessor.
 * Order stores the constant SALES_TAX. It stores the instance of ShoppingCart.
* What methods does each class have? How (if at all) does this differ between the two implementations?
  * Each has an initialize, but they no longer as attribute reader/writers. The Order total_price method no longer calls instance variables from other classes. It only calls an instance variable of ShoppingCart, which was initialized in Order.
* Consider the Order#total_price method. In each implementation:
  * Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
    * Computing the price is retained in Order.
  * Does total_price directly manipulate the instance variables of other classes?
    * No, only those directly called in Order.
* If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
 * This would be easier to change in Implementation B because we would only need to change what is passed into CartEntry unit price and/or quantity.
* Which implementation better adheres to the single responsibility principle?
  * Implementation B better adheres to single responsibility because each class only operates on and calculates its own instance variables.
* Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
  * Implementation B is more loosely coupled. It has less instances of directly calling/naming an instance variable or attribute from other classes or variables.

## Revisiting Hotel
Identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. Describe in design-activity.md what changes you would need to make to improve this design, and how the resulting design would be an improvement.  
BookingManager class takes on multiple roles, some of which are acting on (or creating) attributes of class Reservation. I would need to move several of the functions from BookingManager to Reservation. Making this change would allow my code to more so follow Single Responsibility.
