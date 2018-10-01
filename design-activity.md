https://github.com/Ada-Developers-Academy/textbook-curriculum/blob/master/02-intermediate-ruby/exercises/hotel-revisited.md

1.	What classes does each implementation include? Are the lists the same?
Both implementation create three classes: CartEntry, ShoppingCart and Order.

2.	Write down a sentence to describe each class.
CartEntry represents an item that you would be wanting to purchase and each instance of CartEntry will have a unit price and quantity.
ShoppingCart will contain the entries someone wishes to purchase.
Order is meant to create an instance of a ShoppingCart and apply the sales tax.

3.	How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
Implementation B maintains single responsibility for each of the classes. ShoppingCart will hold what instances of CartEntry will create and Order will calculate the total amount of the order based on the entries within the ShoppingCart.

4.	What data does each class store? How (if at all) does this differ between the two implementations?
CartEntry takes in the unit price and quantity of an entry and is able to return the price for that entry. ShoppingCart holds an array of entries and return the sum of the total items in the shopping cart. The Order class takes an instance of the shoppingcart and calculates the final order price based on the sales tax. Implementation B does this properly, maintaining single responsibility for each of the classes.

5.	What methods does each class have? How (if at all) does this differ between the two implementations?
Each class in both implementations have an initialize method. They differ with the second implementation where a price method is created within each class so it remains single responsibility.

6.	Consider the Order#total_price method. In each implementation:
  a.	Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
Implementation A has the price logic located in Order, while Implementation B has price calculated within each class.
  b.	Does total_price directly manipulate the instance variables of other classes?
In Implementation A it references instance variables but does not modify them. In Implementation B it doesn't manipulate them at all.

7.	If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
Implementation B is easier to modify and you could change the code within the CartEntry class. Implementation A would require a lot more changes to happen.


8.	Which implementation better adheres to the single responsibility principle?
Implementation B

9.	Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled? Implementation B, it can more easily modified. 
