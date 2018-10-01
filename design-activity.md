**What classes does each implementation include? Are the lists the same?**
Both Implementations include the classes CartEntry, ShoppingCart, and Order.
**Write down a sentence to describe each class.**
- In both A and B, CartEntry creates an instance of an item or entry, which has the attributes unit_price and quantity.
- In A, ShoppingCart contains an array of all entries. In B, it contains an array of all entries and calculates the total price of the cart.
- In both, Order calculates the total price of the ShoppingCart including tax.
**How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.**
- Each class refers to data stored in other classes- total relies on items in shopping cart, tax, etc.
**What data does each class store? How (if at all) does this differ between the two implementations?**
- CartEntry stores unit_price and quantity. ShoppingCart stores entries, and in B, the price of the cart as well. Order stores the cart, the value of the sales tax, and the total price of the order.
**What methods does each class have? How (if at all) does this differ between the two implementations?**
- CartEntry initializes the item in both, but in B it also calculates the price of the item. ShoppingCart initializes the entries array, and in B it additionally calculates the price of the entire cart. Order calculates the total price.
**Consider the Order#total_price method. In each implementation:**
**Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?**
- In A, computing the price is the responsibility of Order- although CartEntry stores the price and quantity as well as calculates the price * quantity, order repeats this method. In B, ShoppingCart is responsible for calculating the price of the cart, which makes more sense because it is an attribute of the cart itself, while the order should be responsible for multiplying that price by the SALES_TAX and returning that.
**Does total_price directly manipulate the instance variables of other classes?**
**If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?**
- A would be easier to modify because the price is only calculated once, in the Order class. We could add code to the effect of "if quantity is larger than x, price is $y".
**Which implementation better adheres to the single responsibility principle?**
- A, because each class serves one purpose, but they still rely on and interact with other classes. Also, there is no repeated code.
**Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?**

**Refactors**

I had my total cost method in my BookingSystem class, while it should have been in the Reservation class. This can be copied into the Reservation class, but the references to this method will have to be changed to @reservation instead of @system in the tests as well as wherever this is referenced in other methods. 
