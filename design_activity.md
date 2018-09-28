What classes does each implementation include? Are the lists the same?

Answer:
Each implementation includes 3 classes (CartEntry, ShoppingCart, and Order). It seems like both implementations have the same classes with varying responsible for similar functionality but different methods.

Write down a sentence to describe each class.
Answer:
In implementation A, class CartEntry keeps track of unit price an quantity and both these variables are accessible through the outer reader and writer. ShoppingCart keeps track of all the entires in an array. Order knows the text amount via the constant variable, creates an instance of a shoppingCart and tallies the total cost of the entries and sales tax.

In implementation B, class CartEntry initializes unit price and quantity and also calculates the price of each item. Similarly to implementation A, class ShoppingCart stores the entries in an array but has an additional responsibility of calculating the sum of the item prices in the entries array. Order class keeps track of the sales tax, makes an instance of a ShoppingCart and calculates the grand total by account the sales tax.


How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
Answer:
In implementation class Order is responsible to get the unit price and quantity from CartEntry and get the entry from Shopping Cart. Order depends on both classes to get data to calculate total price. In implementation B its a chain relations were Shopping cart get price of each unit from CartEntry, ShoppingCart is responsible to calculate the prices of each entry and return a subtotal and Order is responsible for getting the subclass from ShoppingCart and calculate grand total.

What data does each class store? How (if at all) does this differ between the two implementations?
Answer:
In implementation A, class CartEntry is responsible to store data for unit price and quantity of each item. ShoppingCart is responsible to store all the entries of the order in an array. Order is responsible to store the tax sale and the variable of total price of the order. In implementation B, similar data are stored in each class but their responsibilities of calculating price is what differs.


What methods does each class have? How (if at all) does this differ between the two implementations?
Answer:

In implementation A only order has methods that calculate the total by accessing information from CartEntry (both unit price and quantity) and entries from ShoppingCart. In implementation B all classes have methods which are responsible in keeping track of prices in their respective domain. CartEntry is responsible to calculate price for each item based on quantity, ShoppingCart is responsible to calculate subtotal for the entry cart items and order is responsible to calculate grand total accounting for sales tax.

Consider the Order#total_price method. In each implementation:

Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
Answer:
In implementation A the computation of total price is retained were as in implementation B the computation is delegated to CartEntry (which is responsible to compute each items prices based on quantity) and ShoppingCart is responsible to computer the entry subtotal.

Does total_price directly manipulate the instance variables of other classes?
Answer:
The total price method access the instance variables of unit_price and quantity for implementation A but doesn’t really manipulate it (assuming manipulating means changing the state of the two variables). Since in implementation A the CartEntry has outer accessor (both read and writer) that total prices in that implementation has the ability to manipulate it.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
Answer:
If items are cheaper in bulk then we need to change the definition in the CartEntry class for both implementations. However, implementation B would be easier to implement as only the inner workings of the class is not reviewed just the method associated with the prices. one other class is dependent on that information and since the unit_price and quantity variables are initialized as outer readers then the order class would be the only class that needs to know this information. In implementation A order is dependent on class entry in two fronts unit price and quantity and dependent on ShoppingCart for entries.  

Which implementation better adheres to the single responsibility principle?
Answer:
Implementation B adheres to the single responsibility principle and has classes that are loosely coupled. Order delegates the responsibility for each class to be calculate the prices instead of doing all the calculation itself.


Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
Answer:
Implementation B has classes that are loosely coupled. Changing things in one class doesn’t affect the entire system.
