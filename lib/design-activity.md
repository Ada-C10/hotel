What classes does each implementation include? Are the lists the same?
Both versions have classes named CartEntry, ShoppingCart, and Order

Write down a sentence to describe each class.
CartEntry - In version A, this class simply creates instance variables of unit_price and quantity -- both to be used in the Order class (so they have attr_accessors).  In version B, this class also includes a price method, which uses the unit_price.  This return is then called by the ShoppingCart class, which is I guess why the attr_accessors are no longer needed.
Shopping Cart - In version A, this class simply creates the empty array where all of the entries go.  In version B, this class takes all of the entries and their price (called from CartEntry?) to find the sum of the prices of all of the entries.
Order - In version A, the Order class is where all of the math happens.  A new instance of ShoppingCart is called and then the summation of the prices happen here (in addition to adding of the sales tax).  In version B, a new instance of ShoppingCart is still created, but the only math that is done is finding the price of each shopping cart and then adding tax to it for the total.


How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
see above.  And, yes, I drew it out on paper :)


What data does each class store? How (if at all) does this differ between the two implementations?
see above.


What methods does each class have? How (if at all) does this differ between the two implementations?
see above.


Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?  In version A, all of the logic happens in the Order method.  In version B, it's delegated to the CartEntry and ShoppingCart classes.

Does total_price directly manipulate the instance variables of other classes? It only adds tax to the total price.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?  It seems like they'd be equal in this regard, because the price and quantity are both dealt with in the CartEntry class (and dealt with upon Initialization).  It doesn't seem like it would change the code at all.

Which implementation better adheres to the single responsibility principle?  I believe version B better adheres to the single use responsibility because in version A there was a ton going on in the Order class.  It was much more difficult to follow.

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?  Version B.  Less arrows pointing from class to class on my sketched diagram!
