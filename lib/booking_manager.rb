require_relative 'room'
require_relative 'reservation'
# require 'pry'

module Hotel
  class BookingManager
    attr_accessor :rooms, :reservations, :room_calendar

    def initialize(number_rooms)
      @rooms = populate_room_list(number_rooms) #(20)
      @reservations = make_reservation_list
      @room_calendar = make_room_calendar(number_rooms)
    end # of def initialize

    # Create list of rooms as list of room Instances
    def populate_room_list(number_rooms)
      rooms = []
      num = 1

      number_rooms.times do |room|
        room = Room.new(num)
        # room = "Room \# #{num}"
        rooms << room
        num += 1
      end # of number_rooms loop

      return rooms
    end # of populate_room_list method

    # Create array to store all of reservations
    def make_reservation_list
      reservations = []
      return reservations
    end

    # Create list of rooms with reserved dates. Change name?
    def make_room_calendar(number) # combine with @rooms?
      @room_calendar = {}

      number.times do |num|
        dates_reserved = {} #[]
        @room_calendar[num+1] = dates_reserved
      end
        # binding.pry
      return @room_calendar
    end

    # # Create a new instance of Reservation # should this and add_reservation be one method?
    #   def reserve(room)
    #   end

    # Method to add a reservation to list of reservations
    def add_reservation(reservation)
      @reservations << reservation
      # @room_calendar
      #
      # reserved_message = "Room successfully reserved"
      # return reserved_message
    end

    # Add reservation date range to hash of room reserved dates
    def add_reservation_to_calendar(reservation)
      date = reservation.start_date

      reservation.number_nights.times do
        @room_calendar[reservation.room][date] = reservation # dependency
        date += 1
      end
  # binding.pry
      return @room_calendar
    end

    # Method to list all reservation instances
    def list_reservations
      return @reservations
    end
    # binding.pry

    # Method to list all rooms in hotel
    def list_rooms
      return @rooms
    end

    # Method to get total cost of reservation
    def get_reservation_cost(nights, cost_per_night)
      total_cost = nights * cost_per_night
      return total_cost
    end

    # Method to check room availability here? Or in room? Or calendar?
    # when check if something is available
    # search through reservations for room with nil -> reserve
    def find_reservations_on_date(date, calendar)
      search_date = Date.parse(date)
      found_reservations = []

       calendar.each do |room, info|
         info.each do |date, reservation|
           if date == search_date
             found_reservations << reservation
           else
            next
          end
        end # of info each
       end # end of calendar each
       # Add return message for no reservations found?
       return found_reservations
    end # of find reservation by date method

    def find_vacancies_on_date(date, calendar)
      search_date = Date.parse(date)
      found_vacancies = []

      calendar.each do |room, info|
        if info == nil
          found_vacancies << room
        else
          info.any? {|date, reservation| date == search_date}? next : found_vacancies << room
        end
      end

      return found_vacancies
    end # of find vacancy

  end # of class BookingManager

end # of module Hotel
