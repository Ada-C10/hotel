# Evaluating Single Responsibility

**What classes does each implementation include? Are the lists the same?**

Implementation A includes classes CartEntry, ShoppingCart, and Order. Implementation B includes the same classes.

**Write down a sentence to describe each class.**

Implementation A:
- CartEntry creates an item in the cart that tracks unit price and quantity.
- ShoppingCart holds cart entries.
- Order creates a shopping cart and calculates the pricing for items and the cart as a whole.

Implementation B:
- CartEntry calculates the price for an item in the cart.
- ShoppingCart calculates the price for an entire cart of entries.
- Order calculates the total price for a cart, including sales tax.

**How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.**

There are many cart entries in one shopping cart, but just one cart per order. There are many cart entries in each order, but indirectly, through ShoppingCart.

**What data does each class store? How (if at all) does this differ between the two implementations?**

- CartEntry stores unit price and quantity for entries.
- ShoppingCart stores an array of entries.
- Order stores the value of sales tax and a cart object.

This is the same for both implementations, but the behavior that relies on that data is divided up differently between A and B.

**What methods does each class have? How (if at all) does this differ between the two implementations?**

Implementation A:
- CartEntry and ShoppingCart only have initialization methods.
- Order initializes a ShoppingCart and has a method that calculates the price per entry, then sums that to get the cart total, then adds the sales tax.

Implementation B:
- CartEntry calculates the price per entry.
- ShoppingCart calculates the price for an entire cart of entries.
- Order adds the sales tax to the shopping cart total.

**Consider the Order#total_price method. In each implementation:**
- **Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?**
- **Does total_price directly manipulate the instance variables of other classes?**

Overall, logic is consolidated in one class (Order) in Implementation A, while in Implementation B, logic for calculating price is spread across all three classes alongside where the data lives for that portion of the price calculation.

In Implementation A, Order's total_price method manipulates instance variables from both ShoppingCart and CartEntry to make its calculation, while in Implementation B, it does not.

**If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?**

It would be much easier to modify Implementation B, because the calculations of price per item are isolated in CartEntry's price method. We could add logic there to alter the calculation based on quantity of an item, and leave the other classes alone. This would be much harder to do in Implementation A because the calculation is wrapped up with the calculations for the entire cart and sales tax.

**Which implementation better adheres to the single responsibility principle?**

Implementation B better adheres to the single responsibility principle because code that reads or modifies instance variables lives in the same class as said instance variables. In Implementation A, Order's total_price method has responsibility for calculating information based off the instance variables of two other classes.

**Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?**

Implementation B is more loosely coupled because it does not know anything about the other classes except that ShoppingCart has a price method.

In Implementation A, the total_price method makes Order tightly coupled with both of the other classes because it knows the instance variables and data structures of ShoppingCart and CartEntry.
