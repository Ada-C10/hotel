module Hotel
  class Reservation
    attr_accessor :id, :room, :start_date, :end_date, :price_per_night, :total_cost
    all_ids = []

    def initialize(reservation)
      @id = id
      @room = room
      @start_date = start_date
      @end_date = end_date
      @price_per_night = price_per_night
    end

    # def self.generate_id
    #   id = rand(1..100000)
    #   if all_ids.include?(id)
    #     raise ArgumentError, "id already exists"
    #   else all_ids << id
    #   end
    #   return id
    # end

    def choose_room
    end

  end
end
