# What classes does each implementation include? Are the lists the same?
Each implementation include: CartEntry, ShoppingCart and Order.
The lists are the same.

# Write down a sentence to describe each class.
 CartEntry: each time when the user add new items into the Cart , taking care of that addition

 ShoppingCart: holding a list of the cart entries , represents all the items user has added to the Shopping Cart.

 Order:  taking care of the order.

# How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

 ShoppingCart contains a list of CartEntry instances.
 Order is generated based on the current items holding in the ShoppingCart.

# What data does each class store? How (if at all) does this differ between the two implementations?
   CartEntry class: stores unit_price and quantity of the entry item.
   ShoppingCart class: stores a list of the CartEntry.
   Order class: stores sales tax rate, a new instance of the SHoppingCart class

   two implementations has no difference.

# What methods does each class have? How (if at all) does this differ between the two implementations?

   CartEntry:  A has read, write methods on instance variable @unit_price and @quantity.    B has a price method to calculate the price of each CartEntry.

   ShoppingCart: A has a read write method on instance variable @entries.  B has a price method on ShoppingCart to calculate the total price of the ShoppingCart

   Order : A has a method to calculate the total price of the order. B is the same as A.

# Consider the Order#total_price method. In each implementation:
#Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

   B : The logic to compute the price delegated to the lower level classes.
   A : it is retained all in order.

# Does total_price directly manipulate the instance variables of other classes?

   B: does not directly manipulate the instance variable s of other classes.
   A: need to access the price and quantity of CartEntry class through ShoppingCart class . 

# If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
  we need to add a conditional statement when calculating the price of that entry, the price should be discounted based on the quantity.
  B is easier for implementation.
  since in B,  order only need to know the price of ShoppingCart, don't need to know how many CartEntries that instance of ShoppingCart holds, and the price & quantity of each CartEntries. The change will only need to be made to the CartEntry class, ShoppingCart class and Order class do not need to know what happened, and no change needed to these two classes.
  while in A, order need to know what happened in other two classes. order need to know how many instances of CartEntry are contained in the ShoppingCart instance, the entry unit_price and entry quantity.
  Order need to access the unit_price and quantity of CartEntry class through the SHoppingCart class to decide if a bulk bought has happened, and to calculate a new total price.

# Which implementation better adheres to the single responsibility principle?
  B is better

# Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
  B is loosely coupled.
