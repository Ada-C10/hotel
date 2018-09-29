## What classes does each implementation include? Are the lists the same? 
Both A and B implementations have the same three classes: CartEntry, ShoppingCart, and Order.

## Write down a sentence to describe each class.
In implementation A:
  * CartEntry instantiates the unit price and quantity of each item.
  * ShoppingCart instantiates an empty array of entries.
  * Order instantiates a ShoppingCart and calculates the total price of the items by referring to the ShoppingCart class for the list of entries and the CartEntry class to get the unit price and quantity of each item.

In implementation B:
  * CartEntry instantiates the unit price and quantity of each item and calculates the price based on the unit price and quantity.
  * ShoppingCart instantiates an empty array of entries and calculates the sum price of all items in the cart.
  * Order instantiates a new ShoppingCart and calculates the subtotal by referring to the ShoppingCart price method.

## How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
In implementation A:
  * Order depends on ShoppingCart to create a new shopping cart instance. To calculate the total price it iterates through the array of entries to calculate the sum of each and add it to the overall cost and apply sales tax.

In implementation B:
  * Each CartEntry calculates its own price, each ShoppingCart calculates its own sum of all entries, and each Order calculates its own subtotal based on the ShoppingCart price and salestax.


## What data does each class store? How (if at all) does this differ between the two implementations?

In implementation A & B:
  * CartEntry: unit_price, quantity
  * ShoppingCart: array of entries
  * Order: ShoppingCart instances
Overall the classes in each implementation store the same data and data types.

## What methods does each class have? How (if at all) does this differ between the two implementations? 

In implementation A:
  * CartEntry: n/a
  * ShoppingCart: n/a
  * Order: total_price

In implementation B:
  * CartEntry: price
  * ShoppingCart: price
  * Order: total_price

In implementation B, each class is responsible for calculating its own price, producing data which can be retrieved/read by the other classes. In implementation A, the Order class is solely responsible for implementing all the calculations. This implementation gives each object a state without specific behaviors. The Order class acts as a high level class that conducts logic across all the classes.


## Consider the Order#total_price method. In each implementation: ## 
* ### Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
    * In implementation A: calculation of total_price is retained solely in the Order class

    * In implementation B: calculation of total_price relies on the lower level classes to implement their own prices which then feed into Order allowing it to sum it all up. 

* ### Does total_price directly manipulate the instance variables of other classes?
    * In implementation A: total_price utilizes the instance variables to calculate a sum, but it does not alter the variables themselves

    * In implementation B: total_price utilizes shoppingcart price to get a subtotal, but it does not modify the price variable.

* ### If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
  * In implementation A: The total_price method would have to contain some conditional statement to check for bulk quantities of CartEntry and implement a separate calculation for such orders. This implementation would get even more complex if certain items were on sale and untangling those item prices from the Order calculation would get super ugly.

  * In implementation B: We could more easily and clearly implement the change within CartEntry's price method. We would still need to create a conditional statement based on quantity, but the changes to the code would be much more readable and less error prone.


* ### Which implementation better adheres to the single responsibility principle?

  * Implementation B, better adheres to the single responsibility principle. Each class provides a specific state and behavior and handles its own logic instead of relying on an external class to implement the necessary price logic.

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
  
  * Implementation B is also more loosely coupled. Dependencies are isolated for price calculations by item, cart, and total order. I'd much rather have this code base to work with and make changes to over implementation A :)