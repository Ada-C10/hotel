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
    end

    # Create list of rooms as list of room Instances
    def populate_room_list(number_rooms)
      rooms = []
      num = 1

      number_rooms.times do |room|
        room = Room.new(num)
        #
        rooms << room
        num += 1
      end

      return rooms
    end

    # Create array to store all of reservations
    def make_reservation_list
      reservations = []
      return reservations
    end

    # Create list of rooms with reserved dates. Change name?
    def make_room_calendar(number) # combine with @rooms?
      @room_calendar = {}
      #
      # number.times do |num|
      #   dates_reserved = {} #[]
      #   @room_calendar[num+1] = dates_reserved
      # end

      # return @room_calendar
      @rooms.each do |room|
        dates_reserved = {}
        @room_calendar[room] = dates_reserved
      end

      return @room_calendar
    end


    # Method to add a reservation to list of reservations
    def add_reservation(reservation)
      @reservations << reservation
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

    def check_dates(start_date, end_date)
      if start_date > end_date
        raise ArgumentError.new "Invalid date range. Start date must be before end date, both in format of 'Month dd, yyyy'. "
      end
    end

    # Method to list all reservation instances
    def list_reservations
      return @reservations
    end


    # Method to list all rooms in hotel
    def list_rooms
      return @rooms
    end

    # Method to get total cost of reservation
    def get_reservation_cost(nights, cost_per_night)
      total_cost = nights * cost_per_night
      return total_cost
    end

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
    end

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

      return found_vacancies.empty? ? no_vacancies_message: found_vacancies
    end

    def no_vacancies_message
      return "There are no vacancies for the given date range."
    end


    def reserve_available_room(guest_name, start_date, end_date)
      check_dates(start_date, end_date)
      @room_available = 0

      res_start_date = Date.parse(start_date)
      res_end_date = Date.parse(end_date)

      @room_calendar.each do |room, reserved_dates|
        if reserved_dates.empty?
          @room_available = room
        end

        unless reserved_dates.empty?
          date_range = []
          search_date = res_start_date

          until search_date > res_end_date
            search_date.each do |search_date|
              date_range << search_date
              search_date += 1
            end
          end

          # date_range && reserved_dates
          day_taken = date_range.map do |date|
            reserved_dates.include? date
          end

          if day_taken.all? {|word| word == false}
            @room_available = room
          end
        end
      # should instead use find_vacancies_on_date method?
      # @room_calendar.each do |room, reserved_dates|
      #   if reserved_dates.empty?
      #     room_available = room
      #   else
      #     search_date = start_date
      #     while search_date < end_date
      #       # search_date.each do |search_date|
      #         if reserved_dates.include? search_date
      #           next
      #         else
      #           room_available = room
      #           exit
      #           # reserved_dates.each do |reserved_dates
      #         end
      #         search_date += 1
      #       # end
      #
      #     end
      #   end

        # binding.pry
      #   # return room_available
      # end #@room each
      # room_available = undefined
      end
      # binding.pry
      new_reservation = Reservation.new(@room_available, guest_name: guest_name, start_date: start_date, end_date: end_date)
      add_reservation(new_reservation)
      add_reservation_to_calendar(new_reservation)
      return new_reservation
    end # def reserve_available_room

  end # of class BookingManager
end # of module Hotel
