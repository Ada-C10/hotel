## Prompts

- What classes does each implementation include? Are the lists the same?
  - `CartEntry`, `ShoppingCart`, `Order`. The lists are the same.
- Write down a sentence to describe each class.
  - `CartEntry`: represents a purchasable/shopping item.
  - `ShoppingCart`: holds all shopping items.
  - `Order`: Determines the price of all items in the shopping cart.
- How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
  - `ShoppingCart` consists of many instances of `CartEntry`. An `Order` has one `ShoppingCart`, and thus (potentially) many `CartEntry` instances.
- What **data** does each class store? How (if at all) does this differ between the two implementations?
  - `CartEntry` stores numeric values `@unit_price` and `@quantity` attributes.
  - `ShoppingCart` stores an array `@entries` attribute.
  - `Order` stores a `ShoppingCart` type attribute called `@cart`.
  - The data under each class does not vary between implementations.
- What **methods** does each class have? How (if at all) does this differ between the two implementations?
  - `CartEntry` has no methods in A, but has a `price` method in B that calculates the total price for a specific type of item.
  - `ShoppingCart` has no methods in B, but has a `price` method that calculates the total price of all `CartEntry` instances in the `entries` array.
  - `Order` in both implementations implements a `total_price` method that calculates the total price of the order, including tax.
- Consider the `Order#total_price` method. In each implementation:
    - Is logic to compute the price delegated to "lower level" classes like `ShoppingCart` and `CartEntry`, or is it retained in `Order`?
      - No in A, yes in B.
    - Does `total_price` directly manipulate the instance variables of other classes?
      - Yes in A, no in B.
- If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
  - One way to do this would be to add another optional parameter to `CartEntry` called `discount`. Then, if the `quantity` is sufficiently high, the price of the item would be discounted by `discount`. In implementation A, we would also have to modify the `total_price` method of `Order` so that if a discount exists, it will be factored into the total cost. In implementation B, if we modify the `price` method in `CartEntry` we do not have to alter any code in `Order`. Therefore, implementation B is easier.
- Which implementation better adheres to the single responsibility principle?
  - B
- Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
  - B because in A, `Order` has to know that `@cart` is made up of elements that respond to `unit_price` and `quantity`.


I have duplicate logic concerning if a date range is within a reservation or room block. I think the best way to handle this duplication is to create a date range class that saves that logic, and lets that be called in reservation and room block. 
