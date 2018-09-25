- What classes does each implementation include? Are the lists the same?
Both implementations include the classes CartEntry, ShoppingCar and Order.

- Write down a sentence to describe each class.
CartEntry keeps track of the unit price and quantity purchased for CartEntry objects.  In implementation B it also returns the price of a cart entry based on the unit price and quantity.
Shopping cart stores a collection of CartEntry objects to be accessed alter. In Imp B it can also calculate the price of all these entries and sum them.
Order creates a ShoppingCart object and returns the final price for the entries in the shopping cart.

- How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
CartEntry objects are the record of the things the customer is actually buying, the the quanity and the price. ShoppingCart stores CartEntry objects. Order uses ShoppingCart to retrieve the prices of the CartEntry objects and calculate the total.

- What data does each class store? How (if at all) does this differ between the two implementations?
CartEntry objects store unit_price and quantity attributes. Shopping cart objects stores an array of CartEntry objects. Order stores a single ShoppingCart and the Constant for Sales Tax.  This is the same in both implementations.

- What methods does each class have? How (if at all) does this differ between the two implementations?
In Imp A CartEntry and ShoppingCart have no methods except for initialize. They have state, but not behavior. The Order class has a total_price method that does the work of collecting information from these other two classes.
In Imp B CartEntry has a method that returns the price for the CartEntry object and ShoppingCart has a method that collects the ShoppingCart sum for all the CartEntry objects that it is storing. So in this implementation these two classes gain behavior.

- Consider the Order#total_price method. In each implementation:
--Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
In imp A all of the logic is in the Order class, while ShoppingCart and CartEntry are only storing objects.
In imp B, logic is delegated to lower level classes.

-- Does total_price directly manipulate the instance variables of other classes?
In imp A, yes, total_price is manipulating the instance variables of other classes.
In imp B, no, total_price is only calling the price method that belongs to a ShoppingCart objects and then it's using the returned information to calculate the final price.

- If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
For imp A we would need to create if/else logic inside our total price method to read the quantity and adjust the unit_price of the item based on whether the quantity was greater than a certain threshold. Either the Order class would be responsible for storing this adjusted unit price or it would need to write the new adjusted unit price to the CartEntry class, which seems outside the responsibility of Order.
For imp B we could have a method with an if/else statement in the price method for the CartEntry class that would adjust the unit price for a CartEntry if the quantity exceeds a certain count. Implementation B is cleaner to modify.

- Which implementation better adheres to the single responsibility principle?
Implementation B

- Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
In imp A Order depends on ShoppingCart and CartEntry and it needs to operate logic on the attributes associated with those classes objects. In imp B Order has no knowledge of ShoppingCart and CartEntry's objects (notice there are no attr_accessor methods even) so this implementation is more loosely coupled.

____________________________________________________________________________

Changes to Hotel:
1. Remove the reservation_charge method from the hotel admin class because this method is not needed. The functionality is adequately covered in the reservation class so this is needless repetition.

2. I am tracking reservations in both the hoteladmin class and in the room class. This means that if I delete a reservation in one location I would need to do it in both place. The rooms class also has very little behavior while the hoteladmin class is overloaded with responsibility. Without redesigning the entire project the best way I can come up with to fix this is to move some of the methods from hoteladmin into the room and make the room class the soul party responsible for storing and answering questions about reservations.

3. Available method in Room class is inefficient and using nested loops. It is inefficient to loop through each night in the range and this can be cleaned up by using a conditional.

4. Clean up some issues with tests identified by code review
