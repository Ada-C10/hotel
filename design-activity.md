Activity: Evaluating Responsibility
As an example, here are two different implementations of a system to keep track of orders in an online shopping cart.

Implementation A
class CartEntry
  attr_accessor :unit_price, :quantity
  def initialize(unit_price, quantity)
    @unit_price = unit_price
    @quantity = quantity
  end
end

class ShoppingCart
  attr_accessor :entries
  def initialize
    @entries = []
  end
end

class Order
  SALES_TAX = 0.07
  def initialize
    @cart = ShoppingCart.new
  end

  def total_price
    sum = 0
    @cart.entries.each do |entry|
      sum += entry.unit_price * entry.quantity
    end
    return sum + sum * SALES_TAX
  end
end
Implementation B
class CartEntry
  def initialize(unit_price, quantity)
    @unit_price = unit_price
    @quantity = quantity
  end

  def price
    return @unit_price * @quantity
  end
end

class ShoppingCart
  def initialize
    @entries = []
  end

  def price
    sum = 0
    @entries.each do |entry|
      sum += entry.price
    end
    return sum
  end
end

class Order
  SALES_TAX = 0.07
  def initialize
    @cart = ShoppingCart.new
  end

  def total_price
    subtotal = @cart.price
    return subtotal + subtotal * SALES_TAX
  end
end
Prompts
Once you have read through the above code, add a file to your Hotel project called design-activity.md. This file will be submitted with the rest of this exercise. In that file, please respond to the following prompts:

What classes does each implementation include? Are the lists the same?
Write down a sentence to describe each class.
  Each implementation has: CartEntry, ShoppingCart, and Order classes.
  CartEntry = the price and quantity are stored as instance variables upon initialization. Implemetation B's version also has the instance method price which returns the product of the unit price and quantity.
  ShoppingCart = an empty array (instance variable entries) is created upon initialization. For implementation B, it also has the instance method 'price', which sums the price of each entry in the array @entries.
  Order = for implementation A, the Order creates a new instance of ShoppingCart upon initialization.




How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
What data does each class store? How (if at all) does this differ between the two implementations?
What methods does each class have? How (if at all) does this differ between the two implementations?
Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
Does total_price directly manipulate the instance variables of other classes?
If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
Which implementation better adheres to the single responsibility principle?
Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
Once you've responded to the prompts, git add design-activity.md and git commit!
