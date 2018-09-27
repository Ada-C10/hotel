## Hotel Design Activity

**What classes does each implementation include? Are the lists the same?**

Both implementations have 3 classes by the same names: CartEntry, ShoppingCart, Order.


**Write down a sentence to describe each class.**

CartEntry represents the addition of a given product to a cart, including its price and quantity.

ShoppingCart represents a collection of everything that has been added to a cart.

Order represents the total cost of everything in a given cart, including sales tax.


**How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.**

ShoppingCart contains each CartEntry. Order calculates the total of the ShoppingCart after sales tax.


**What data does each class store? How (if at all) does this differ between the two implementations?**

CartEntry: both implementations store the prices and quantities of a given product. In implementation A, those values can be accessed outside of the class due to the attr_accessor whereas in Implementation B, they have to be used locally.

ShoppingCart: both implementations have an array that stores each CartEntry object. In Implementation A, those entries can be accessed outside of the class. Implementation B also has a value for the sum of all entries in the cart.

Order: both implementations store the sum/subtotal, or total price of a complete order (before sales tax). This is calculated differently in each implementation. Implementation A iterates through each price and quantity in @entries. Implementation B calls the #price method from ShoppingCart.


**What methods does each class have? How (if at all) does this differ between the two implementations?**

CartEntry: both implementations have an initialize method. Implementation B also has a price method that returns the subtotal of one particular item.

ShoppingCart: both have an initialize method.

Order: both have an initialize method that creates a new instance of a ShoppingCart. Both also have a total_price method that returns the total of all cart entries plus sales tax. The difference is that the method in Implementation A handles all of the logic for "sum" whereas Implementation B calls the "price" method in the ShoppingCart class.


**Consider the Order#total_price method. In each implementation:**
**Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?**

In Implementation A, the logic is retained in Order. In Implementation B, the logic relies on ShoppingCart, which is a lower level class.


**Does total_price directly manipulate the instance variables of other classes?**

In Implementation A, total_price reads @entries from ShoppingCart and @unit_price and @quantity from CartEntry. In Implementation B, total_price does not read instance variables of any other class.


**If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?**

You would need to add some conditional logic that lowers the :unit_price based on :quantity. Implementation A is harder to modify because that logic would need to be called into account in the CartEntry class and Order class. Implementation B is easier to modify because you would only need to modify the CartEntry class.


**Which implementation better adheres to the single responsibility principle?**

Implementation B.


**Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?**

Implementation B.
