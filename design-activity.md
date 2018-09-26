*1) What classes does each implementation include? Are the lists the same?*

Both implementations utilize the CartEntry, ShoppingCart, and Order classes.

*2) Write down a sentence to describe each class.*

CartEntry represents the price and quantity of an item that a user can put into their cart (and in Implementation B, it calculates its own total price).

ShoppingCart holds a list of CartEntry items (and in Implementation B, it calculates its own total price).

Order creates a new ShoppingCart and calculates the total price of the items in the cart (including sales tax).

*3) How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.*

An Order contains a single ShoppingCart, which contains one or more CartEntry items.


*4) What data does each class store? How (if at all) does this differ between the two implementations?*

CartEntry stores 'unit_price' and 'quantity'.
ShoppingCart stores 'entries', an array of CartEntry items.  Order stores 'cart', an instance of ShoppingCart.
The stored data is the same for both implementations.

*5) What methods does each class have? How (if at all) does this differ between the two implementations?*

CartEntry has no methods in A, but has a 'price' method in B which calculates the total price based on unit price and quantity.

ShoppingCart has no methods in A, but has a 'price' method in B that sums all of the prices for individual CartEntry items in the 'entries' array/.

Order has a 'total_price' method in both implementations.  
In A, 'total_price' does all the work of computing the individual price per item (based on unit price and quantity), summing up all of the prices in the cart, and adding the sales tax.
In B, 'total_price' calls the cart's 'price' method to get the total price before tax, then adds the sales tax.


*6) Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?*

In A, all of the computational logic is put into the Order#total_price method.  In B, the logic is spread through the lower level classes so that Order has to do less work.


*7) Does total_price directly manipulate the instance variables of other classes?*

In A, total_price directly accesses the ShoppingCart's 'entries' instance variable and also calls upon the 'unit_price' and 'quantity' instance variables of the CartEntry items in the cart.

In B, total_price does not directly access any instance variables of other classes.  Instead, it calls the 'price' method of the ShoppingCart class.


*8) If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?*

If the quantity of the CartEntry item affects the unit price of the item, we would have to add logic (in the form of a conditional statement) to check how many items are being ordered and adjust the price accordingly.  Since this change would happen on a per-item basis, the code in Implementation B would be much easier to modify (add logic in the CartEntry class).



*9) Which implementation better adheres to the single responsibility principle?*

Implementation B is a better example of single responsibility.  In A, the Order class takes on the responsibilities of both the CartEntry and ShoppingCart classes, leaving those classes with no methods.


*10) Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?*

Implementation B is more loosely coupled because the Order class does not need to know as much information about the other two classes.  In A, Order needs to know that ShoppingCart has an array named 'entries' AND that the items in the array have both a 'unit_price' and 'quantity'.  In B, Order only needs to know that ShoppingCart has a method named 'price' (it doesn't need to know anything about the array or the CartEntry items in this case).



*Based on the answers to each set of the above questions, identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. Describe in design-activity.md what changes you would need to make to improve this design, and how the resulting design would be an improvement.*

A room should be able to do all of the work of checking its own availability instead of having the Hotel (this needs to get renamed) class do part of the work. Hotel#add_reservation_to_room should call a method within the room instead of directly modifying the room's 'reservations' instance variable.  The price of a room is not dependent on the room itself, but rather which type of reservation the room is being booked into, so Room should not have any price information. 
