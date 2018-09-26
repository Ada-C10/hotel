#### What classes does each implementation include? Are the lists the same?
Both implementations have the same classes: CartEntry, ShoppingCart,  and Order.

#### Write down a sentence to describe each class.
Implementation A:
CartEntry: Has a unit price and a quantity method.
ShoppingCart: Has an entries method which consists of an array of entries.
Order: Has a sales tax variable, a cart method which consists of a ShoppingCart instance, and a total price method which calculates the total price for shopping cart entries and adds the sales tax (as a percentage).

Implementation B:
CartEntry: Has a unit price,  a quantity , and a price method.
ShoppingCart: Has an entries method which consists of an array of entries and a price method which sums all of the entries prices.
Order: Has a sales tax variable, a cart method which consists of a ShoppingCart instance, and total price method which called the price method on the ShoppingCart instance and adds the sales tax (as a percentage).

#### How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
Implementation A: One Order instance generates one ShoppingCart instance. A ShoppingCart instance has instances of CartEntry. Order uses CartEntry's unit_price and quantity through the ShoppingCart instance in the total_price method.
One Order to one ShoppingCart. One ShoppingCart to many CartEntry instances.

Implementation B: One Order instance generates one ShoppingCart instance. A ShoppingCart instance has instances of CartEntry. Order has a method, total_price, that uses ShoppingCart's price method. ShoppingCart's price method uses CartEntry's price method. One Order to one ShoppingCart. One ShoppingCart to many CartEntry instances.

#### What data does each class store? How (if at all) does this differ between the two implementations?
Implementation A:
CartEntry: price and quantity
ShoppingCart: cart entries
Order: ShoppingCarts and total price

Implementation B:
CartEntry: price and quantity
ShoppingCart: cart entries and their prices
Order: ShoppingCarts and total price with tax

#### What methods does each class have? How (if at all) does this differ between the two implementations?
Implementation A:
CartEntry: unit_price, quantity
ShoppingCart: entries
Order: total_price

Implementation B:
CartEntry: price
ShoppingCart: price
Order: total_price

#### Consider the Order#total_price method. In each implementation:
#### Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
Implementation A: It is retained in Order.
Implementation B: It is retained in ShoppingCart and CartEntry.

#### Does total_price directly manipulate the instance variables of other classes?
Implementation A: I don't think so. It is just calling them and using them to calculate a new total_price.
Implementation B: It's calling price on ShoppingCart which then calls it on CartEntry,  but isn't changing anything, so no.

#### If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
I think they would be equally easy to change. CartEntry has a unit_price and quantity method for both implementations, and the quantity would need to be updated for things to be in bulk, unless a new class is being created. If a new class is being created then the second implementation would be easier to change.

#### Which implementation better adheres to the single responsibility principle?
I'm not sure. The first implementation has more single responsibility classes, but the second implementation has equally spread out responsibilities. Maybe I'm having trouble understanding these concepts and should talk about it with a teacher?

#### Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
I think the second implementation is more loosely coupled.

#### Based on the answers to each set of the above questions, identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. Describe in design-activity.md what changes you would need to make to improve this design, and how the resulting design would be an improvement.
I don't think my Hotel class modifies any attributes of other classes. It uses them to check things and create instances. My Hotel class does take on multiple roles, but I'm not quite sure how to fix that. I think I'm going to follow my refactors.txt and change some aspects according to POODR chapter 3. Otherwise, I'm not sure what else I can do. I don't see how the Implementations in the Hotel Revisited exercise apply to my code. I'm not calculating anything in Hotel, just generating reservations and checking that rooms are available. I'm not sure about what is required for this assignment.

Refactors:
Changed all but one of direct references to classes. (there is a Reservation.new on line 132).
Moved "dates_overlap?" method to the Reservation and BlockRooms classes.
Removed Room class.
