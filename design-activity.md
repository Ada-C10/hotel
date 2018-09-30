**What classes does each implementation include? Are the lists the same?**
- Implementation A includes classes CartEntry, ShoppingCart, and Order.
- Implementation B includes the same three classes as A.

**Write down a sentence to describe each class.**
- CartEntry stores the unit price and quantity of an item.
- ShoppingCart stores an array of CartEntry instances.
- Order calculates the total cost of all items in the ShoppingCart.

**How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.**
- Order has a ShoppingCart, ShoppingCart has many CartEntry's, and CartEntry does not relay on either of the other classes.

**What data does each class store? How (if at all) does this differ between the two implementations?**
- CartEntry stores the unit price and quantity of an item. ShoppingCart stores an array of CartEntry instances, and Order stores one instance of ShoppingCart. This is the same for both implementations.

**What methods does each class have? How (if at all) does this differ between the two implementations?**
- Both implementations have initialize methods in all classes. In implementation A, CartEntry and ShoppingCart only store state (no behavior, i.e. methods). Order has the total price method. In implementation B, CartEntry and ShoppingCart both have a price method, and Order has the total price method.

**Consider the Order#total_price method. In each implementation:**
**Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?**
- In Implementation A, logic to compute the price is retained in Order. In implementation B, logic to compute the price is delegated to "lower level" classes.

**Does total_price directly manipulate the instance variables of other classes?**
- In Implementation A, total price manipulates the instance variables in CartEntry by multiplying the unit price and quantity. In Implementation B, total price does not directly manipulate the instance variables of other classes.

**If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?**
- If we decide items are cheaper if bought in bulk, then the code in the CartEntry class should change (for example, a conditional could be added to manage this). Implementation B would be easier to modify since I would be working directly with CartEntry and making a small adjustment it, instead of the mess that Order might become if I added this functionality in Implementation A.

**Which implementation better adheres to the single responsibility principle?**
- Implementation B better adheres to the single responsibility principle.

**Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?**
- Implementation B is more loosely coupled. Changing the functionality in one class, CartEntry, does not affect or cause the other classes to change. In addition, classes in Implementation B call on the methods of other classes instead of manipulating the state directly.

**Identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. What changes would you need to make to improve this design, and how will the resulting design be an improvement?**
- In the HotelManager class, I noticed that the make_reservation method modifies the attribute room_list of the Block class. I created an instance method in the Block class called change_status so that HotelManager does not have more than one responsibility. The change was quick, and all my tests continue to pass. The resulting design is an improvement since this functionality actually falls under what the Block class should do, I can make changes there without having to make a slew changes in other places too.
