What classes does each implementation include? Are the lists the same?
CartEntry, ShoppingCart, Order (yes, they are the same)

Write down a sentence to describe each class.
In Implementation A
CartEntry initializes with unit_price and quantity for each cart item (passed in as params)... these attributes are both readable and writable
ShoppingCart initializes an array of empty cart items
Order initializes with an instance of a new and empty shopping cart and contains the method to calculate the total price by calling instance vars in CartEntry and using constant SALES_TAX which it alone knows about

In Implementation B
CartEntry initializes with unit_price and quantity for each cart item (passed in as params)... these attributes are neither readable nor writable once passed in. It also calculates price for that item
ShoppingCart initializes with an array of empty cart items and calculates the shopping card price by using the price method in each item (entry)
Order initializes an empty shopping cart. It also calculates total_price for the order by using the price method in ShoppingCart and SALES_TAX, which is a constant stored in Order.


How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
(See above)

What data does each class store? How (if at all) does this differ between the two implementations?

CartEntry stores its unit_price and quantity.
ShoppingCart stores entries, instances of CartEntry.
Order stores a SALES_TAX, common across all orders.
The main difference is that in ImplementationB, CartEntry knows about and handles calculating its own price, ShoppingCart knows about and calculates its own price, where this is all managed in Order (and Order manages calculating the overall total price including SALES_TAX in both implementations)

What methods does each class have? How (if at all) does this differ between the two implementations?
(see above)

Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
Implementation A: retained in Order
Implementation B: delegated to "lower level" class

Does total_price directly manipulate the instance variables of other classes?
It shouldn't. I think no?

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
I guess ImplementationB, since cart price (and subsequent each entry) cost is just accessed here in total_price; whereas, in Implementation A, it's relying on each entry being singular with a singular price.

Which implementation better adheres to the single responsibility principle?
ImplementationB since each class handles calculating price for itself.

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
ImplementationB is more loosely coupled. This is because Order only knows about an instance of ShoppingCart, and it's public method price; whereas in Implementation A, Order knows about its instance of ShoppingCart plus two public methods in CartEntry (price and quantity). Implementation A can also change these two attributes for each entry, which is bad because now CartEntry is now highly dependent on order.   It would be better, and less coupled, if you could just create a method to delete the entry from the cart (instead of changing values in the entry)
