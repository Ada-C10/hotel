module Hotel
  class Room
    attr_reader :id
    attr_accessor :cost

    def initialize(id)
      @id = id
      @cost = 200
    end

    def set_discount(new_cost)
      @cost = new_cost
    end
    
  end
end
