# Design Activity
https://github.com/Ada-Developers-Academy/textbook-curriculum/blob/master/02-intermediate-ruby/exercises/hotel-revisited.md

## Prompts

#### What classes does each implementation include? Are the lists the same?
Both implementations have the same three classes: `CartEntry`, `ShoppingCart`, and `Order`.

#### Write down a sentence to describe each class.
| Class | A | B |
| :------------ | :------------- | :------------- |
| CartEntry     | **State:** knows its unit price and its quantity. | **State:** knows its unit price and its quantity. <br><br> **Behavior:** can calculate its own price. |
| ShoppingCart  | **State:** stores an array of CartEntries. | **State:** stores an array of CartEntries. <br><br> **Behavior:** can ask each CartEntry for its price, and then calculate the subtotal (price of all entries in the array). |
| Order         | **State:** knows the SALES TAX constant, stores an instance of the ShoppingCart class. <br><br> **Behavior:** can calculate a CartEntries price, can calculate a ShoppingCart's price, and can assemble the two into a total price. | **State:** knows the SALES TAX constant, stores an instance of the ShoppingCart class. <br><br> **Behavior:** can ask the ShoppingCart for its price (subtotal), and then calculate the total price. |

("stores" == "knows")

#### How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

The difference between A and B is that the Order class is concerned with *how* (A) versus *what* (B).

In A, the Order class knows too much outside of its "jurisdiction" -- it knows *how* to calculate CartEntry's price and *how* to calculate ShoppingCart's price. In A, classes are tightly coupled.

In B, the Order class asks CartEntry *what* its price is, asks ShoppingCart *what* its price is, and, from there, knows *how* to calculate a total price. In B, classes are loosely coupled.

#### What **data** does each class store? How (if at all) does this differ between the two implementations?
Classes store the **State** described in the above table.

#### What **methods** does each class have? How (if at all) does this differ between the two implementations?
Classes have methods for the **Behavior** described in the above table.

#### Consider the `Order#total_price` method. In each implementation:
  - Is logic to compute the price delegated to "lower level" classes like `ShoppingCart` and `CartEntry`, or is it retained in `Order`?  

A: the latter. B: the former.

  - Does `total_price` directly manipulate the instance variables of other classes?  

A: yes. B: no.

#### If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

In the real world, like on Zazzle.com or CafePress.com, items are likely to each have unique wholesale price brackets based on quantity (though I suppose it could be something like 10% off if you spend $100 or more). Going with the former, we'd do this by adding some data - probably a price_table of quantities and prices, either an array of arrays or an array of hashes.

To modify A, CartEntry's unit_price has to be changed to price_table, and Order's total_price method has to be changed to include an enumerable method to look up a price by a quantity.

To modify B, CartEntry's unit_price also has to be changed to price_table, and CartEntry's price method also has to be changed to look up a price by a quantity.

B is easier to modify because changes in one class do not necessitate changes in another class. The person making the change doesn't have to hunt through the code to figure out effects of the change. The change is more proportional to the cost of change. There's less risk of far-off, hidden, unwanted effects of change.

#### Which implementation better adheres to the single responsibility principle?

I think B does, but I also think that classes in both A and B are *seemingly* single-responsibility. In both A and B, CartEntry has price and quantity, ShoppingCart has entries, and Order has a cart and a total price.

However, I think B is the better answer because A's CartEntry can and should shift the responsibility of knowing about the instance variables of other classes from itself to the classes in question.

#### Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

B!
