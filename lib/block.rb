module Hotel
  class Block < BookingSystem
    attr_accessor :block_id, :number_of_rooms, :assigned_rooms

    def initialize(id:, number_of_rooms:, assigned_rooms:, start_date:, end_date:, discounted_price:)
      @id = id
      @number_of_rooms = number_of_rooms
      @assigned_rooms = assigned_rooms
      @start_date = start_date
      @end_date = end_date
      @discounted_price = discounted_price
    end

    def assign_rooms(start_date, end_date)
      open_rooms 

      # return
    end
  end
end
