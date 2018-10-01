1. The two implementations have the same classes but their utilization and functionality of the class are different.
2. Implementation A:
    - Cart Entry: stores data for individual cart entries
    - Shopping Cart: stores a collection of instances of cart entries
    - Order: creates and calculates full order details
  Implementation B:
    - CartEntry: stores data for individual entry and calculates price
    - ShoppingCart: stores collection of instances of entries and calculates sum of a cart.
    - Order: calculates total order cost including Tax and stores instances of Cart
3. In Implementation A - the classes are heavily dependent upon one another. The Order class depends on the ShoppingCart class and does all of the work. Any changes done in one of the lower classes changes the Order class.

Implementation B - the classes are still dependent upon each other but are more loosely coupled because each of the classes includes a specific class method that will calculate price. A change in one of the lower classes has less of an event on the Order class.

4. Data - in both classes each class stores the same data except implementatin B also calculates out price per entry and shopping Cart in addition to just storing quantity and unit price.

5. Implementation A - The order class stores all the methods and functionality that this program would need to accomplish. It creates an instance of the cart and then calculates it's total cost.

Implentation B - Each of the classes is able to calculate the cost/price associated with its specific object. This makes the classes more independent of each other.

6. I think it makes sense to delegate price computation to lower classes and still have total computed in order. Each class is responsible for knowing the information respective to the instances and objects it creates. In implementation A, total_price manipulates instances of the other classes to produce a total. In implementation B, total_price does not directly manipulate instances of other classes but instead calls upon them to use their own methods to give it what it needs.

7. To include a discount for bulk buying, it would be much easier to implement this new feature in Impmentation B. The variable and corresponding method change could be added to the lower level classes and the class Order would be non the wiser to the change but still deliver what the program needs to accomplish.

8. Both Implementations mostly stick to the single responsibility principles except for Implementation A's Order class. Implementation A stores data about a cart and calculates its total cost but is also responsible for calculating the costs of the instances in the two other classes.

9. ImplementationB is more loosely coupled.

--

Hotel
- Reservation manager
  - manages/creates relationships between rooms and reservations
  - Room factory can be moved to the room class.
  - There is no code in the lower classes that would directly influence instance variables in this class.

- Reservation
  - holds all pertinent information to a specific instance of reservation
  - refactor reservation to be more generic and usable for block rooms.
- Room
  - holds all pertinent information to a specific room
  - can take on the factory of rooms from ReservationManager Class

- Block
  - manages information specific to a block.
