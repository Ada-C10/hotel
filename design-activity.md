# Activity: Evaluating Responsibility

## Prompts
Once you have read through the above code, add a file to your Hotel project called design-activity.md. This file will be submitted with the rest of this exercise. In that file, please respond to the following prompts:

### What classes does each implementation include? Are the lists the same?
Write down a sentence to describe each class.
  Each implementation has: CartEntry, ShoppingCart, and Order classes.
  CartEntry = the price and quantity are stored as instance variables upon initialization. Implemetation B's version also has the instance method price which returns the product of the unit price and quantity.
  ShoppingCart = an empty array (instance variable entries) is created upon initialization. For implementation B, it also has the instance method 'price', which sums the price of each entry in the array @entries.
  Order = the Order creates a new instance of ShoppingCart upon initialization. Both implementations have instance method 'total_price', however in implenentation A, the sum is calculated by using the instance variable entries in the ShoppingCart class with the instance variable cart in the Order class. In implementation B, the method stays within the class, using Order's instance varialbe cart only.




### How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
  Implementation A - the classes are interwoven, attr_accessor is used to interweave the classes together. The Order class is reliant on the CartEntry and ShoppingCart classes for calculating total price.

  Implementation B - the classes are more independent from each other, the Order class is reliant only on information from the ShoppingCart method and only because a new ShoppingCart is initialized with its creation.



### What data does each class store? How (if at all) does this differ between the two implementations? What methods does each class have? How (if at all) does this differ between the two implementations?
  In implementation B, all classes not only store information but are responsible for calculations for each instance of itself. In implementation A, however, Order is responsible for everyone.


### Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
Does total_price directly manipulate the instance variables of other classes?
  In implementation B, it is delegated to lower level classes, in A it directly manipulates the other classes' instance vars.


### If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
Which implementation better adheres to the single responsibility principle?
  Implementation B isn't as tightly woven as A. Since all classes are responsible for their own thing and have their own methods that perform calculations, it is much easier to create a class or other edit. As opposed to A which must be fully changed from top-bottom in order to add that functionality.


### Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
  Implementation B


Once you've responded to the prompts, git add design-activity.md and git commit!

****

Now that we've got you thinking about design, spend some time to revisit the code you wrote for the Hotel project. For each class in your program, ask yourself the following questions:

What is this class's responsibility?
You should be able to describe it in a single sentence.
Is this class responsible for exactly one thing?
Does this class take on any responsibility that should be delegated to "lower level" classes?
Is there code in other classes that directly manipulates this class's instance variables?
You might recall writing a file called refactor.txt. Take a look at the refactor plans that you wrote, and consider the following:

How easy is it to follow your own instructions?
Do these refactors improve the clarity of your code?
Do you still agree with your previous assesment, or could your refactor be further improved?
****

### Based on the answers to each set of the above questions, identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. Describe in design-activity.md what changes you would need to make to improve this design, and how the resulting design would be an improvement.
  Changed a bunch of stuff, remove CSV stuff since it didn't work out, change some methods and clearly separate module from class. Moved module methods to Concierge class, but I think the program as a whole needs a rehaul. 


If you need inspiration, remember that the reference implementation exists.

Then make the changes! Don't forget to take advantage of all the tests you wrote - if they're well structured, they should quickly inform you when your refactoring breaks something.

Once you're satisfied, git commit your changes and then push them to GitHub. This will automatically update your pull request.
