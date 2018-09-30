**What classes does each implementation include? Are the lists the same?**
They each include ```CartEntry```, ```ShoppingCart```, and ```Order```. The lists are the same.

**Write down a sentence to describe each class.**
```CartEntry``` is in charge of each item placed into the cart (quantity+price).
```ShoppingCart``` is in charge of all the items placed into the cart (as an array).
```Order``` is in charge of finalizing all pricing details for all the items in the cart.

**How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.**
Each cart item is instantiated via ```CartEntry```. When we instantiate ```Order```, we also instantiate a new instance of ```ShoppingCart``` within the constructor. I imagine in the driver code, we would pass in ```CartEntry``` items to ```Order.cart```when instantiating ```Order```. SO ```ShoppingCart``` has many ```CartEntry``` items -- and ```Order``` has one ```ShoppingCart``` (along with its many ```CartEntry``` items)

**What data does each class store? How (if at all) does this differ between the two implementations?**
In both, ```CartEntry``` stores ```@unit_price``` and ```@quantity``` of each item. In both, ```ShoppingCart``` stores ```@entries``` (as an array). In both, ```Order``` stores ```@cart``` (an instance of ```ShoppingCart```). There are no differences in state between the two.

**What methods does each class have? How (if at all) does this differ between the two implementations?**
```CartEntry```
Implementation A: nothing beyond the constructor.
Implementation B: ```price```, which returns the price for each item entry.
```ShoppingCart```
Implementation A: nothing beyond the constructor.
Implementation B: ```price```, which returns the subtotal for the entire cart.
```Order```
Both have ```total_price```, which calculates the total price for the cart, including the sales tax.

**Consider the Order#total_price method. In each implementation:**
* **Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?**
In Implementation A, the logic is relegated only to ```Order```. In Implementation B, the pricing is built in the "lower level" classes first before ```Order``` completes the final calculation.
* **Does total_price directly manipulate the instance variables of other classes?**
In Implementation A, ```total_price``` directly manipulates ```CartEntry```'s instance variables (like ```@price```).
In Implementation B, ```total_price``` only interacts with ```ShoppingCart```'s methods.

**If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?**
We would need to change the code in ```CartEntry``` to add a discount for bulk items (likely an optional parameter) and a way to determine if ```quantity``` meets the threshold for the bulk item discount (likely through a conditional).  Implementation B would be easier to modify, since you'd really only need to make an edit in one place (```CartEntry```), whereas more work would be needed in Implementation A since it doesn't know anything about a discount or bulk quantity criteria yet those influence the pricing for each item (which Implementation A's ```Order``` directly references).

**Which implementation better adheres to the single responsibility principle?**
Implementation B. ```Order``` in Implementation A does too much work and knows too much about ```CartEntry``` in particular.

***Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?**
Implementation B (see above).
