# Hotel Revisted

## Prompts
1. What classes does each implementation include? Are the lists the same?
Write down a sentence to describe each class.

`CartEntry` - Takes a unit price and quantity
`ShoppingCart` - Holds instances of entries
`Order` -  Will combine all the shopping cart items to get a total price for the order

Both implementations have the same classes.

1. How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

Implementation A & B- The Order has 1 instance of a shopping cart, and the ShoppingCart has CartEntries.

1. What data does each class store? How (if at all) does this differ between the two implementations?

They store the same information but in Implementation A they attributes can be read and written from different classes.
Implementation A & B:
  - CartEntry - stores unit price and quantity
  - ShoppingCart - stores instances of CartEntry
  - Order - stores one instance of a shopping cart


1. What methods does each class have? How (if at all) does this differ between the two implementations?

Implementation A:
  - CartEntry - No methods
  - ShoppingCart - No methods
  - Order - total_price
Implementation B:
  - CartEntry - price
  - ShoppingCart - price
  - Order - total_price

1. Consider the Order#total_price method. In each implementation:
  - Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
    Implementation A the logic is retained in Order
    Implementation B the logic is delegated ot the other classes
  - Does total_price directly manipulate the instance variables of other classes?
    Yes, in Implementation A
1. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
  Implementation B because we could change at the CartEntry level the price if it were bulk instead of changing our total_price method in Order.
1. Which implementation better adheres to the single responsibility principle?
  Implementation B better adheres to the single responsibility principle.

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
  B!
