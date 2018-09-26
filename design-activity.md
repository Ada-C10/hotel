What classes does each implementation include? Are the lists the same?

  Implementation A has CartEntry, ShoppingCart, and Order classes. Implementation B has the same classes but differs in behavior.

Write down a sentence to describe each class.

  CartEntry keeps track of the cost for a unit and it's quantity.
  ShoppingCart holds an array of CartEntry objects.
  Order initializes a new ShoppingCart object and calculates the total plus tax of all CartEntrys in that object.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

  One CartEntry has 1 ShoppingCart.
  One ShoppingCart has many CartEntry's.
  One Order has 1 ShoppingCart.

What data does each class store? How (if at all) does this differ between the two implementations?

  CartEntry stores the unit price of a unit and it's quantity.
  ShoppingCart stores an array (assuming to be populated with CartEntry's).
  Order stores a new instance of ShoppingCart.

  In implementation A, these data are readable and writable by the user. In implementation B, the user is only able to access these variables by an instance method (.price).


What methods does each class have? How (if at all) does this differ between the two implementations?

  For implementation A, CartEntry has an initialize method and attr-accessor methods for unit-price and quantity. In implementation B, CartEntry has the same initialize method and a price method that returns that cost of the sum of units.

  ShoppingCart has a similar setup as CartEntry between implementations A and B. In A, it has attr-accessor and initialize method. In B, it has the initialize and a price method that returns the cost of the sum of CartEntry's.

  Order has the same methods of initialize and total_price between each implementation. In implementation B, however, the total_price method relies on instance methods of the ShoppingCart class to retrieve the subtotal.


Consider the Order#total_price method. In each implementation:
- Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

  For implementation A, computation is the responsibility of Order. In implementation B, Order relies on message sends from the ShoppingCart class who in turn relies on computations performed in the CartEntry class.

- Does total_price directly manipulate the instance variables of other classes?

  In implementation A, total_price only accesses instance_variables of other classes but could manipulate them due to their instance variables being wrapped in attr_accessor methods.
  In implementation B, total_price does not directly manipulate the instance variables of the other classes.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

  If items are cheaper if bought in bulk, that would modify the cost of of a CartEntry object. It would need some factor for a bulk discount that would take effect once the quantity reaches a certain threshold. This would be easier to modify in implementation B.

Which implementation better adheres to the single responsibility principle?

  Implementation B adheres better to the single responsibility principle.

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

  Implementation B is more loosely coupled. A's Order class knows about both of the other class's instances variables. In B, each class relies on message sends from one other class.
