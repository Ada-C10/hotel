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


What classes does each implementation include? Are the lists the same?
Implementation A classes:
1 - CartEntry
2 - ShoppingCart
3 - Order

Implementation B classes:
1 - CartEntry
2 - ShoppingCart
3 - Order

The lists are the same

Write down a sentence to describe each class.
Implementation A classes:
1 - CartEntry: Initializes a new instance of an item's price and quantity
2 - ShoppingCart: Stores all the entries in an array
3 - Order: Creates a new instance of a ShoppingCart, and calculates the total price of items in the cart

Implementation B classes:
1 - CartEntry: Same as A
2 - ShoppingCart: Same as A
3 - Order: Same as A

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
In A, the CartEntry class instantiates 2 variables, @unit_price and @quantity. These are used in the the Order class to calculate sum. IN the class ShoppingCart, @entries is instantiated. this instance variable is also used in the Order class to also calculate the sum

In B, CartEntry class instantiates @unit_price and @quantity which are used in a method within the class. This method uses these variables to return a price. In ShoppingCart class, @entries in instantiated and another price method is created, this method uses the price from the CartEntry class to calculate the sum of items in the cart. This price is then used in the Order class to calculate the total price of all items


What data does each class store? How (if at all) does this differ between the two implementations?
In A & B, CartEntry stores unit_price and quantity.
      ShoppingCart stores entries
      Order stores SALES_TAX, cart


What methods does each class have? How (if at all) does this differ between the two implementations?
IN A, the only class that has methods is Order. This calculates total_price.

In B, CartEntry stores price method.
      ShoppingCart stores another price method.
      Order stores a total_price method like A

Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
In A, it is retained in Order
In B, it is delegated to lower level classes

Does total_price directly manipulate the instance variables of other classes?
In A, total_price does manipulate the instance variables of other classes
In B, total_price does not manipulate them

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
In B, we could create another class that would have bulk prices that could return a bulk price that could be added to the order class. Or just add a bulk_price to CartEntry that would be added to the price method.
In A, a bulk_price could be added to CartEntry but then Order would also have to be changed to add it there too.

Which implementation better adheres to the single responsibility principle?
B

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
B
