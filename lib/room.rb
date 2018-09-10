class Room
  attr_reader :room_number, :dates
  attr_accessor :status
  def initialize(room_number, status = :available)
    @room_number = room_number
    @status = status # valid_status = [:available, :reserved, :blocked]
    # @reservations = reservations # [array of reservation hash]
    @dates = []

    raise ArgumentError if room_number > 20

  end

  # def self.all_available(date)
  #   match reservation date and room availability
  #   returns all availble rooms found
  # end


  # def find_rooms(number_of_rooms) => helper method?
  #   find number_of_rooms that are availble
  #   assign to a reservation
  # end
end
