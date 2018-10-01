1. Both implementations contains the same three classes--CartEntry, ShoppingCart, and Order.

2. CartEntry - Responsible for a single entry in a ShoppingCart, tracks unit_price of an item and quantity of that item being purchased.

   ShoppingCart - Responsible for multiple CartEntries.

   Order - Responsible for calculating total price of a particular ShoppingCart

3. CartEntry (one or many)
           v
   ShoppingCart (only one)
           v
         Order

4. CartEntry - price of a single unit of an item, quantity of that item being purchased
   ShoppingCart - holds multiple individual CartEntries
   Order - sales tax constant, a single ShoppingCart

   The data stored by each class does not change between implementations

5. CartEntry - #price returns the price of a quantity of some item
   ShoppingCart - #price returns the price of all entries in the cart
   Order - #total_price returns the cart price + sales tax

   Implementation A uses attr_accessor to make the data from CartEntry and ShoppingCart available to Order so it can calculate the total price, but Implementation B provides instance methods for each that return their respective prices, so that Order can simply call @cart.price then add sales tax.

6. In Implementation B, the price logic is delegated to lower level classes, but in Implementation A it is not.

   total_price does directly manipulate the instance variables of other classes in Implementation A, but not in B.

7. Ideally we would be working with Implementation B and could just add conditional functionality in CartEntry#price that affected unit price based on quantity. In Implementation A we would need to modify the code in Order#total_price, which is both unintuitive and messy.

8. Implementation B, absolutely. I've made my case above... lol

9. Once again, B.


-----------


In RoomBooker#new_block_reservation, the local `room` variable is used to modify the state of the Room struct, which belongs to the RoomBlock instance. If I were to handle this functionality instead within the RoomBlock class itself in an instance method, my classes would be even more loosely coupled and resilient to future change/easier to change in the future.
