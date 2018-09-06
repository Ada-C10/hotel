module Hotel
  class Reservation
    attr_reader :room
    attr_accessor :guest_name, :start_date, :end_date, :cost_per_night

    def initialize(room, guest_name:, start_date:, end_date:, cost_per_night: 200.00)
      @room = room.number
      @guest_name = guest_name
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @cost_per_night = cost_per_night
    end # of initialize method

  end# of class Reservation
end #of Hotel module
