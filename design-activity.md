1. What classes does each implementation include? Are the lists the same?
Each implementation includes the classes: CartEntry, ShoppingCart, and Order.
No, the lists aren't the same. In A, the instance variable @entries is both readable and writable. In B, @entries is not readable or writable.



2. Write down a sentence to describe each class.
CartEntry --- it is the blueprint for new CartEntry objects, each object will be instantiated with @unit_price and @quantity attributes. (In A, the attributes are both readable and writable, but not in B.)

ShoppingCart --- it contains the list of entries as an instance variable @entries.

Order --- it is the blueprint for Order objects, each order is instantiated with a @cart attribute which is a list of @entries. (Each time an Order object is instantiated, it calls ShoppingCart.new and assigns it to the local variable @cart.)  


3. How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
?? how can @cart call on entries? i thought it was set to equal ??

CartEntry is the factory for all entries, ShoppingCart stores all entries as a list, Order has a method that iterates through the list of entries, and performs a math operation on each entry to find the total price of an Order (by multiplying entry.unit_price by entry.quantity then summing the price of all entries).



4. What data does each class store? How (if at all) does this differ between the two implementations?
ShoppingCart is the only class that stores data, it stores a list of entries.
In A, the instance variable @entries stores the list of entries and it is both readable and writable outside of the ShoppingCart class.
In B, the instance variable @entries stores the list of entries but is not accessible outside of the ShoppingCart class.



5. What methods does each class have? How (if at all) does this differ between the two implementations?
Both classes have initialize methods which initialize CartEntry with @unit_price and @quantity, ShoppingCart with @entries as an array, and Order with @cart as ShoppingCart.new(which is basically an array).

In B, CartEntry has an additional method that A doesn't have called #price which performs a math operation between @unit_price and @quantities (instance variables defined in its own class) and returns the price of an entry.
In B, ShoppingCart also has a method that A doesn't have called #price which iterates through the list of @entries (the instance variable defined in its own class) to add up and return the sum of all entries.
The Order class in A and B both contain #total_price. In A, the instance variable @cart needs call on entries to then iterate through each entry in order to first view their unit_price and quantities and then multiply by the tax to perform the math operation to find the total price of the order. In B, the instance variable @cart needs to just call price then multiply by the tax to find the total price.


6. Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
Does total_price directly manipulate the instance variables of other classes?
If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
Which implementation better adheres to the single responsibility principle?
Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
