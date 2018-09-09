module Hotel
  class Block
    attr_accessor :block_id, :number_of_rooms, :start_date, :end_date, :price_per_night

    def initialize(block_id:,  number_of_rooms:, start_date:, end_date:, price_per_night:)
      @block_id = block_id
      @number_of_rooms = number_of_rooms
      @start_date = start_date
      @end_date = end_date
      @price_per_night = price_per_night
    end

    # def assign_available_room(start_date, end_date)
    #   if @number_of_rooms > 5
    #     raise ArgumentError, "Cannot block more than 5 rooms"
    #   end
    #   return available_rooms[0..(@number_of_rooms.to_i - 1)]
    # end
  end
end
