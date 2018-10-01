What classes does each implementation include? Are the lists the same?
  Both implementations have the same classes - CartEntry, ShoppingCart, and Order.

Write down a sentence to describe each class.
  CartEntry creates entries (items to be purchased).
  ShoppingCart keeps track of a collection of entries.
  Order calculates the total price of a ShoppingCart.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
  An Order has one ShoppingCart.
  A ShoppingCart has many CartEntries.

What data does each class store? How (if at all) does this differ between the two implementations?
  Both implementations store the same data.
  CartEntry stores unit_price and quantity in instance variables.
  ShoppingCart stores instances of CartEntry in an array.
  Order stores SALES_TAX in a constant.

What methods does each class have? How (if at all) does this differ between the two implementations?
  Implementation A:
    CartEntry has a unit_price and quantity method.
    ShoppingCart has an entries method.
    Order has a total_price method.
  Implementation B:
    CartEntry and ShoppingCart have price methods.
    Order has a total_price method.
  All classes in both implementations have constructor methods.

Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
  Implementation A:
    All logic to compute the price is retained in Order.
  Implementation B:
    Logic to compute the price is delegated to the lower level classes CartEntry and ShoppingCart in the price methods.

Does total_price directly manipulate the instance variables of other classes?
  Implementation A:
    Order#total_price directly manipulates the entries instance variable from ShoppingCart by iterating over the array.
  Implementation B:
    This implementation doesn't directly manipulate instance variables of other classes and instead uses the price instance methods to achieve the same result as implementation A.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
  Adding a discount for items bought in bulk could be achieved by storing additional data in the CartEntry class - perhaps a hash with quantities as keys and discounts as values.
  I think it would be easier to modify implementation B; you could add the hash to CartEntry and wouldn't need to change anything else. Since the price calculation is done in the CartEntry class (not in the Order class as in implementation A), this shouldn't cause unexpected changes in other classes.

Which implementation better adheres to the single responsibility principle?
  I think implementation B better adheres to SRP, because each class calculates it's own price.

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
  I struggled with tight coupling in Hotel, but I think implementation B is more loosely coupled, because it doesn't directly manipulate the instance variables of other classes. Only the public price methods are used to send messages between objects, rather than the instance variables/methods in implementation A.

Improve Hotel design:
  There are many changes I'd like to make, and I added more notes to refactor.txt based on the instructor feedback. However, I think the most significant item to focus on is the tight coupling where BookingManager directly accesses instance variables in Calendar and Block, because these types of dependencies can be dangerous. BookingManager and Calendar aren't as cohesive as they could be, and I think as I try to eliminate these dependencies it makes sense to move around some of the logic in these classes so they better adhere to SRP. With looser coupling and more cohesive classes, my application will be more resilient to change.
