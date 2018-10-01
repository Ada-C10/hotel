1. What classes does each implementation include? Are the lists the same?

  Both implementations include the same three classes, CartEntry, ShoppingCart, and Order. Yes, each implementation returns the same list.


2. Write down a sentence to describe each class.

  The CartEntry class creates an instance of an order item, which has the attributes unit price and quantity. In the second implementation, it contains the method price, which calculates the price of the item by multiplying the price of the item by the quantity of items ordered.

  The ShoppingCart class creates an instance of a cart, which stores an array of cart item objects as an instance variable `@entries`. The second implementation contains the method price, which calculates the total of all cart items in the shopping cart.

  The Order class creates an instance of an order, which stores an instance of a shopping cart object as an instance variable `@cart`. It's behavior calculates the total price of the order by getting the sum of each cart item in the shopping cart and multiplying the sum with a constant sales tax variable.



3. How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

  The Order class stores an instance of ShoppingCart object, which we can use to calculate the total price of a cart including the sales tax. Each ShoppingCart stores instances of CartEntry, and we can get the total price of the shopping cart by calling the method price on the cart (this method gets the subtotal of the cart without taxes). The CartEntry class stores an instance of a cart item which has the attributes unit price and quantity. We can get the price of a cart item entry by calling on the price method which multiplies the price of the item by the quantity ordered.

  In other words, an Order has one shopping cart, a ShoppingCart has many cart entries, and a CartEntry has one entry item.


4. What data does each class store? How (if at all) does this differ between the two implementations?

  The CartEntry class stores a cart entry item.
  The ShoppingCart class stores instances of CartEntry objects.
  The Order class stores an instance of ShoppingCart.

  Both implementations store the same data, but the behaviors of the classes differ. The second implementation wraps the attributes in an instance method, while the first implementation uses the attr_accessor to access the instance variables of the class.

5. What methods does each class have? How (if at all) does this differ between the two implementations?

    **Implementation A**
    --- | CartEntry | ShoppingCart | Order
    --- | --- | --- | ---
    Methods | `initialize`, `attr_accessor` | `initialize`, `attr_accessor` | `initialize`, `total_price`

    **Implementation B**
    --- | CartEntry | ShoppingCart | Order
    --- | --- | --- | ---
    Methods | `initialize`, `price` | `initialize`, `price` | `initialize`, `total_price`

    The two implementations differ in that the second implementation wraps the instance variables in an instance method and calls on that instance method to determine price in each class. On the other hand, the first implementation calls on the attr_accessor method from the other classes to determine the price in just one class, the Order class.


6. Consider the Order#total_price method. In each implementation:

  * Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

  First implementation: price is retained in Order
  Second implementation: price is delegated to lower level classes, ShoppingCart and CartEntry


  * Does total_price directly manipulate the instance variables of other classes?

  First implementation: directly manipulates the instance variables of other classes
  Second implementation: does not manipulate the instance variables, but uses the instance methods to get price


7. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

  The second implementation is easier to change because we can add a conditional to the `price` method to lower the unit price if quantity is greater than or equal to a set amount.

  The first implementation would be harder to change because all the logic is in the Order class, and is too dependent on the CartEntry and ShoppingCart classes.



8. Which implementation better adheres to the single responsibility principle?

  Implementation B better adheres to the single responsibility principle because each class has one responsibility and the class's dependencies on each other are minimal. They are loosely coupled, and implementing changes are easier compared to Implementation A.



9. Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

  Implementation B is more loosely coupled.



## Improvements on Hotel

<!--
What is this class's responsibility?
You should be able to describe it in a single sentence.
Is this class responsible for exactly one thing?
Does this class take on any responsibility that should be delegated to "lower level" classes?
Is there code in other classes that directly manipulates this class's instance variables?
You might recall writing a file called refactor.txt. Take a look at the refactor plans that you wrote, and consider the following:

How easy is it to follow your own instructions?
Do these refactors improve the clarity of your code?
Do you still agree with your previous assesment, or could your refactor be further improved?




 -->



### Class Responsibilities:

* Reservation:
  - Responsible for holding one reservation instance
  - BookingSystem calls on the reservation's instance variable `date_range`, but thought it was appropriate because `date_range` is an instance of class DateRange. This way, I can call on a method on DateRange and do the work there instead of in the BookingSystem class.

* DateRange:
  - Responsible for validating available dates
  - Instance variables are not directly manipulated, methods used to validate dates

* BookingSystem:
  - Responsible for creating all reservations (room and blocks)
  - Knows about all other class, but the other classes know little about each other

* BlockRoom:
  - Responsible for holding a block of rooms with a discounted rate
  - Like Reservation, the instance variable `date_range` in BlockRoom is called in BookingSystem


## Hotel Refactors:
  * Updated logic of the `dates_overlap` method
  * Added custom error exception within the DateRange and BookingSystem class
  * Removed `list_rooms` method since the method was redundant and attr_reader returns the same thing
  * Fixed logic error in BookingSystem method `find_available_rooms` where nils were being populated in the array
