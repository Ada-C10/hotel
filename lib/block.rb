module Hotel
  class Block
    attr_accessor :block_id, :number_of_rooms, :assigned_rooms, :start_date, :end_date, :discounted_price

    def initialize(block_id:,  number_of_rooms:, assigned_rooms:, start_date:, end_date:, discounted_price:)
      @block_id = block_id
      @number_of_rooms = number_of_rooms
      @assigned_rooms = assigned_rooms
      @start_date = start_date
      @end_date = end_date
      @discounted_price = discounted_price
    end

    # def assign_available_room(start_date, end_date)
    #   if @number_of_rooms > 5
    #     raise ArgumentError, "Cannot block more than 5 rooms"
    #   end
    #   return available_rooms[0..(@number_of_rooms.to_i - 1)]
    # end
  end
end
