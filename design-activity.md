What classes does each implementation include? Are the lists the same?
Write down a sentence to describe each class.

The first implementation has a CartEntry class, a ShoppingCart class and an Order class with a total_price method. The second implementation has a price method  in the CartEntry class that returns a sum based on unit price and quantity; a price method in the ShoppingCart class that collects the price for each entry and stores in variable named sum which will hold the price totals of all entries; there is a total price method in the Order class that takes the price of a ShoppingCart instance and stores into a variable called subtotal. This subtotal is added by itself and multiplied by a SALES_TAX to return a total for all items in cart.
----------
How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

In the first implementation - To create an order instance, a ShoppingCart instance must also be created. They are tied together. This creates a coupling affect. The second implementation allows each class to calculate a sum. With the first class - the price of each item can be calculated based on its quantity. A shopping cart instance does not need to be created just to get the sum. There is also a price method that returns the sum of (the sum of all items). If one were to just want to see that price for an item based on its quantity, that is done entirely separate from the ShoppingCart class. Lastly there is a total price that DOES require information from another classes method to function. However a total price cannot be assessed without having a shopping cart thus this makes sense.
-----
What data does each class store? How (if at all) does this differ between the two implementations?
The second implementation's classes each have a method that calculates a sum. The first implementation - The order class stores dat of a shopping cart instance and calculates the price using the data from the CartEntry class.
-----
What methods does each class have? How (if at all) does this differ between the two implementations?
The first implementation has an instantiation and a total_price while while the second has a price method for each class except the Order class holds the totl price method. The second method removes dependencies on other classes.
-----
Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
Does total_price directly manipulate the instance variables of other classes?
The first implementation delegates the computation through its dependency on lower level classes like ShoppingCart and CartEntry while the second implementation retains that computation within Order.
----
If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify? The second implementation seems better because you can assign prices per item based on quantity before placing it in a cart. 
----
Which implementation better adheres to the single responsibility principle?
implementation B
----

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
Once you've responded to the prompts, git add design-activity.md and git commit!
