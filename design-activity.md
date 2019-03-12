# What classes does each implementation include? Are the lists the same?
IMPLEMENTATION A includes the CartEntry class, the ShoppingCart class, and the Order class

IMPLEMENTATION B includes the CartEntry class, the ShoppingCart class, and the Order class
The both have the same classes' names
# Write down a sentence to describe each class.
CartEntry class initializes a instance of an entry, it has price of the entry and the quantity of this entry
ShoppingCart class initializes an instance of a Cart, it has the an array of entries
The Order class calculates the total cost for the entries in the cart
# How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
IMPLEMENTATION A: The Order class depends on the ShoppingCart class to create the cart with an entries array. The Order class, calculates the total price for all entries in the cart.

IMPLEMENTATION B: The Order class depends on the ShoppingCart class to create the cart with an entries array. The ShoppingCart class calculates the price for all the items in the cart
# What data does each class store? How (if at all) does this differ between the two implementations?
IMPLEMENTATION A:
CartEntry stores unit price and quantity of an entry
ShoppingCart stores all the entries in an array
Order stores the cart that contains all the entries

IMPLEMENTATION B:
CartEntry stores the unit price and quantity of an entry
ShoppingCart stores the all the entries in an array
Order stores the cart that contains all the entries
This does not differ between the two implementations

#What methods does each class have? How (if at all) does this differ between the two implementations?
IMPLEMENTATION A:
CartEntry: no methods
ShoppingCart: no methods
Order: total_price method to calculate the price for each entry, the price for all entries, and the total price including tax

IMPLEMENTATION B:
CartEntry: price method to calculate the price for the entry (quantity and unit price)
ShoppingCart: price method to calculate total price for the cart (all entries)
Order: total price method to calculate the total price including tax

#Consider the Order#total_price method. In each implementation:
#Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
#Does total_price directly manipulate the instance variables of other classes?
IMPLEMENTATION A: It's retained in Order
total_price directly manipulate instance variables of other classes (it calls the unit price and quantity instance variables from the Cart Entry, and the entries instance variable from the ShoppingCart class)

IMPLEMENTATION B: It computes the price delegated to "lower lever" classes. The computes the total cost by applying the tax.
total_price doesn't directly manipulate instance variables of other classes (it calls the price method, but it is not an instance variable)

#If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
IMPLEMENTATION A: you will have to add an if statement in the do loop to calculate a discount if entry.quantity is of a certain number before adding it to the sum variable

IMPLEMENTATION B: you will need to change the price method in the CartEntry class by calculating a discount if quantity is of certain items.

IMPLEMENTATION B is easier to modify
#Which implementation better adheres to the single responsibility principle?
IMPLEMENTATION B because code that reads or modifies the instance variables of a class is wrapped in a method of that class
#Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
IMPLEMENTATION B is more loosely coupled because code that reads or modifies the instance variables of a class is wrapped in an instance method on that class. 
