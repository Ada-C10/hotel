### What classes does each implementation include? Are the lists the same?

Each implementation includes the classes CartEntry, ShoppingCart, and Order. In Implementation A, CartEntry and ShoppingCart both have initialize as only methods and class Order has initialize and total_price. In Implementation B, CartEntry and ShoppingCart has price method in addition.

### Write down a sentence to describe each class.

CartEntry initializes with the unity price and quantity of the entry. ShoppingCart initializes with an empty array of entries. Order initializes by creating a new instance of ShoppingCart and has a method to calculate the total price. In Implementation B, each class can calculate their own price on their own (whether it's price for entry, price for shopping cart, or total price in order including tax).

### How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

CartEntry is added to an array in ShoppingCart. Order can calculate the total price from the shopping cart's entries. In implementation B, the price is calculated in every class so that Order doesn't need to do the calculating logic using CartEntry and ShoppingCart's instance variable and can instead get the subtotal by using @cart.price.

### What data does each class store? How (if at all) does this differ between the two implementations?

CartEntry stores the unit_price and quantity, ShoppingCart stores an array of CartEntry objects. Order stores one instance of ShoppingCart. There are additional methods in implementation B (the price method) but those calculate and return the sum, not store the data.

### What methods does each class have? How (if at all) does this differ between the two implementations?

Other than initialize, CartEntry and ShoppingCart have a price method that can return the price of each entry or cart in implementation B. In implementation A, only Order had a total_price method which did not adhere to single responsibility and used variables from ShoppingCart and CartEntry.


### Consider the Order#total_price method. In each implementation:
### Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

In implementation A, it's retained in Order. In implementation B, it's delegated to CartEntry and ShoppingCart.

### Does total_price directly manipulate the instance variables of other classes?

In A, yes. in B, no.

### If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

Implementation B makes the change easier to modify the code in CartEntry (such as a conditional loop) instead of trying to make that logic work in Order.

### Which implementation better adheres to the single responsibility principle?

Implementation B.

### Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

Implementation B. The total_price in Order doesn't require knowing the unit price and quantity of each CartEntry.
