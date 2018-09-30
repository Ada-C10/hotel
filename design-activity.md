### What classes does each implementation include? Are the lists the same?

Each implementation includes the classes CartEntry, ShoppingCart, and Order. In Implementation A, CartEntry and ShoppingCart both have initialize as only methods and class Order has initialize and total_price. In Implementation B, CartEntry and ShoppingCart has price method in addition.

### Write down a sentence to describe each class.

CartEntry initializes with the unity price and quantity of the entry. ShoppingCart initializes with an empty array of entries. Order initializes by creating a new instance of ShoppingCart and has a method to calculate the total price. In Implementation B, each class can calculate their own price on their own (whether it's price for entry, price for shopping cart, or total price in order including tax).

### How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.


CartEntry is added to an array in ShoppingCart. Order can calculate the total price from the shopping cart's entries.


### What data does each class store? How (if at all) does this differ between the two implementations?


### What methods does each class have? How (if at all) does this differ between the two implementations?


###Consider the Order#total_price method. In each implementation:
###Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?


###Does total_price directly manipulate the instance variables of other classes?


###If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?


###Which implementation better adheres to the single responsibility principle?


###Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
