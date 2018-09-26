What classes does each implementation include? Are the lists the same?
Write down a sentence to describe each class.

    Implementation A
    CartEntry class: initializes unit price and quantity variables
    ShoppingCart class: initializes an array of entries
    Order class: initializes a new shopping cart, calculates total price using cart entries and uses the unit price and quantity of each cart entry.


    Implementation B
    CartEntry class:  initializes unit price and quantity variables, calculates the price of each cart entry
    ShoppingCart class: initializes an array of entries, calculates price (cart total) using the sum of prices for all cart entries  
    Order class: initializes a new shopping cart, calculates total price, by adding sales tax and shopping cart price.

    The two implementations have the same list of classes. But the classes do different things, in implementation B. Calculations for prices and done within individual classes unlike A which does all the calculations in the Order class.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

    ShoppingCart is populated with an array of CartEntry instances, it also calls the CartEntry method price and used in defining ShoppingCart#price.

    Order is populated with an instance of ShoppingCart. It has a method total price that calls the ShoppingCart#price method.


What data does each class store? How (if at all) does this differ between the two implementations?


    CartEntry contains two integers variables (I'm assuming unit price and quantity will be integers). The class does not store data, it creates a CartEntry.

    ShoppingCart has an array stored in the @entires variable that stores instances of CartEntry.

    Order contains the @cart variable which is an instance of ShoppingCart. The class does not store any data

What methods does each class have? How (if at all) does this differ between the two implementations?

    Implementation A
    CartEntry has no methods
    ShoppingCart has no methods
    Order has total_price method

    Implementation B
    CartEntry has a price method
    ShoppingCart has a price method
    Order has a total_price method


Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

    Implementation A
    The price logic is retained in Order

    Implementation B
    The price logic is delegated to lower level classes

Does total_price directly manipulate the instance variables of other classes?

    total_price does not directly manipulate the instance variables of other classes.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

    Implementation B will be easier to modify because it is loosely couple. 

Which implementation better adheres to the single responsibility principle?
    Implementation B


Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
    Implementation B is more loosely coupled because classes are responsible for their prices unlike in Implementation A.
