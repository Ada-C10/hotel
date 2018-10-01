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
6.1) Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order? In A it is retained in Order, in B it is delegated.

6.2) Does total_price directly manipulate the instance variables of other classes? Yes it does in A but not in B.

6.3) If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify? B is easier to modify.

6.4) Which implementation better adheres to the single responsibility principle?
Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
B is more loosely coupled and adheres better to the single responsibility principle.

<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
~~ Refactor Activity: ~~
Based on the answers to each set of the above questions, identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. Describe in design-activity.md what changes you would need to make to improve this design, and how the resulting design would be an improvement.

One design issue I have in TrackingSystem is that it has too many jobs. One design change I can make to improve this is by moving some date checking logic out of this class and into the Reservation class. In TrackingSystem I'm currently iterating through the list of reservations in order to be able to perform
date checking logic, and it could just be done in the Reservation class itself. Moving the date checking logic to the Reservation class will be an improvement because the TrackingSystem will need to know less about the structure and variables of the Reservation class and it will DRY up the code in certain methods that iterate through
the list of reservations.

Extra notes...

Questions to keep in mind:
-should the instance variables be readable and writable?
-should there be a class thats job is just to store data?
-can some computing logic be delegated to lower classes?

1. The TrackingSystem class takes on multiple roles
  a. it creates all the rooms
  b. it stores the list of blocks, list of reservations, and list of rooms
  *c*. it contains date checking logic that checks on a reservation to determines a room and block's availability
  d. it adds new blocks and new reservations to its data

2. The TrackingSystem directly modifies the attributes of
  a. a room's reserved dates and its block status
  b. a reservation's price
  c. a block's reserved dates, block status and rooms inside it

3. The Room class takes on multiple roles
  a. it keeps track of a list of dates that it is unavailable which is doing too much it should let the TrackingSystem class be the only place where reservations data is kept. I realized that most of the methods in TrackingSystem are going through the Room objects to check the reservation status, when it should be checking that through Reservation objects. 
