1. Implementation A has three classes: CartEntry, ShoppingCart, and Order.
Implementation B has the same three classes as well.

2. For implementation A, CartEntry initializes the unit price and quantity for each item. ShoppingCart stores the entries of each item in an array. Order creates a new instance of a shopping cart and then calculates the total price of all the items in a cart with the sales tax.

For implementation B, CartEntry initializes the unit price and quantity for each item. ShoppingCart stores the entry of each item in an array and also calculates the price of each item. Order creates a new instance of a shopping cart and calculates the total price of each cart with all the items and the sales tax.

3. For implementation A, the CartEntry establishes the quantity and price of each item. ShoppingCart stores each entry. These two classes are needed for the Order class which creates a new instance of a shopping cart and then goes through each entry in the cart to calculate the sum of all the items and their prices. It returns the total price.

For implementation B, CartEntry is responsible for establishing the unit price and and quantity of each item. Then it calculates the price of each type of item depending on the quantity ordered. ShoppingCart stores the entry of each item in a shopping cart. It also calculates the price of each entry by calling on the price method in CartEntry and then adding up the sums. Order creates a new instance of shopping cart. It calculates the subtotal by calling on the price method from ShoppingCart. Then it calculates the overall cost by multiplying the subtotal to the sales tax and adding that to the original subtotal amount.

4. CartEntry stores each item's price and quantity. ShoppingCart stores all the entries. Order retrieves the information from CartEntry and ShoppingCart to return the total price of each cart. Both store the same info. However, I think implementation A does a better job of creating single responsibility for each class without relying too heavily on the Order class to calculate the total price. However, the subtotal variable in implementation B is much clearer on what is being calculated vs, implementation A where the variable sum is used. I wasn't sure why sum was being returned at first.

5. Initially, it seemed logical to compute the the price in "lower level" classes like ShoppingCart and CartEntry. However that creates a tie between all the classes and if one is changed, then the others must be modified as well. In the first implementation, ShoppingCart doesn't rely on price being calculated in CartEntry and then Order doesn't rely on ShoppingCart for price to be calculated in order for the total price to be calculated. Total price does not directly manipulate the instance variables of the other classes.

6. If items were bought in bulk, I think this would be done in a new method called bulk. I think because method A is more loosely coupled than B, it would be easier to implement in A.

7. Implementation A.  

8. Implementation A. Although I think implementation B is a little easier to read because the variable subtotal in the method total_price was clearer to me.
