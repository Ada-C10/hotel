1.  Implementation A contains the following classes: CartEntry, ShoppingCart and Order. Implementation B also contains the following classes: CartEntry, ShoppingCart, Order. The lists are the same.

2.  The CartEntry class contains the price of an item and the quantity of the item that the user wishes to purchase. The ShoppingCart class contains an array of CartEntry objects that the user wishes to purchase. The Order class contains a salestax constant and a cart that contains an instance of the ShoppingCart class.

3.  The Order object contains one ShoppingCart object (one to one). The ShoppingCart object contains many or one CartEntry.

4. In CartEntry, it's states (the data stored) are: @unit_price, which is the cost of the item, and @quantity, which is the amount of the items. ShoppingCart contains @entries, an array of CartEntry objects. Order contains @cart, an instance of ShoppingCart and a salestax constant. One difference is that in the ShoppingCart class, Implementation B stores the quantity * price of the item in the entries while Implementation A only stores the price of a single item.

5. In CartEntry, Implementation A doesn't have any behavior(methods) and Implementation B has a .price which calculates an item's price times the quantity of item's that the user wants. In ShoppingCart, Implementation A had no methods and Implementation B had .price which calculates the sum of the price of all the CartEntry objects in @entries. In Order, Implementation A has a total_price method that calculates that did all of the things that Implementation's B's methods did and also calculated sales tax, while Implementation B had a total_price method that calculated the sales tax and subtotal, which was calculated in the previous classes.

6.  a. The logic to compute the price was delegated to lower level classes in Implementation B. In implementation A, it is retained in Order.
    b.  total_price directly manipulates the instance variables from the other classes in Implementation A

7.  I would say that it would be easier in Implementation B, and the change that I think would be made is in the CartEntry class. An additional discount can be taken out if the quantity of items bought is equal to or higher than the min amount needed to get bulk status, then the .price would reflect the discount. Or, another method could be written in that class to calculate the bulk discount and that method can be used to help that within the .price method. In implementation A, this would be harder to do but still possible, it would be done in the Order class, in the total_price method.

8.  Implementation B better adheres to it.
