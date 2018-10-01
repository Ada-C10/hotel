What classes does each implementation include? Are the lists the same?
  Both implementation include classes named CartEntry, ShoppingCart, Order. If you mean the class name list by "list" then yes, the list is the same for both implementations.

Write down a sentence to describe each class.
  For implementation A, class CartEntry stores unit price and quantity. Class ShoppingCart stores all entries in an array. Class Order stores all entries from ShoppingCart then calculates the cost of all entries including tax.

  For implementation B, class CartEntry stores unit price and quantity while also being able to calculate cost of the merchandise with its cost and quantity. Class ShoppingCart stores all entires and can calculate the total cost for all entires. Class Order stores all entries, gets the total price from ShoppingCart then adds tax to calculate total sum.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

  For implementation A, ShoppingCart is directly instantiated in Order with .new but CartEntry's instance variables are also called in Order. Order is the big class that brings all classes together.

  For implementation B, CartEntry's instance method price, price, is called in ShoppingCart inside it's instance method, price. ShoppingCart's price method is called in Order's instance method, total_price.

What data does each class store? How (if at all) does this differ between the two implementations?
  For A, CartEntry holds unit_price and quantity, ShoppingCart holds all entires, Order holds all entries and total sum.

  For B, CartEntry holds unit_price, quantity,  price of one merchandise w/o tax,  ShoppingCart holds all entires with price of all merchandise w/o tax, Order holds all entries and total sum with tax.

  Difference is that B holds more data and has more behavior for each of its classes compared to A. A has 2 classes that just holds state.

What methods does each class have? How (if at all) does this differ between the two implementations?
  A: Only order has an instance method but all classes do have the initialize method. Order#total_price method.

  B: CartEntry#price method, ShoppingCart#price method, Order#total_price method.

  Difference: B has more instance methods in each class so more behavior.

Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
  A: retained in order

  B: delegated to lower level classes

Does total_price directly manipulate the instance variables of other classes?
  A: yes, because total_price directly iterates over @cart.entries which is manipulating the instance variable of ShoppingCart.

  B: no, because total_price simply calls the ShoppingCart#price method then assigns it to a local variable then adds the tax to that local variable.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
  It would change the unit price to drop if one buys 10 folders in quantity for one order instead of 10 orders with 1 folder. So it could be an if statement of if quantity is multiples of 10 then minus price by 2 dollars.

  B is easier to modify because the if statement can go inside #price method of CartEntry class. For A, I would either need to create an if statement inside the initialize method or create it inside the iteration of the total_price which would make it have too much responsibility in one method.

Which implementation better adheres to the single responsibility principle?
  B. Because each class has both state and behavior while having one single responsibility.

HOTEL REVISITED:

what changes you would need to make to improve this design, and how the resulting design would be an improvement.
  BookingSystem takes on the role of checking for overlapping dates which is more than what it should do. Reservation class could instead become a date range class and it could address the overlapping date ranges there. This will allow BookingSystem to have less responsibilities.

  Then I could still have a reservation class where it takes in the confirmed date ranges that can be used to make a reservation and assign a room number to that date range in that class.

  I did not finish wave 2 before when we submitted this project so I focused on completing that part. Then I focused on breaking down the methods with less responsibility for the #make_reservation method.

  The way the methods are set up makes sense for them to be in BookingSystem so I had difficulty with fleshing the responsibilities out in BookingSystem. I am still working on breaking down the booking_system class so I have not committed a repo with a newly improved design but it does have better methods with less responsibility.
