module Hotel

  class ReservationMatcher

    attr_reader :reservations, :rooms

    def initialize
      @reservations = []
      @rooms = 20.times.map { |room| Room.new() }
    end

    # As an administrator, I can reserve a room for a given date range
    def make_reservation(checkin_date, checkout_date)

      #TO DO: check for valid date input
      #how to check invalid dates? #USE REGEX!!!! [MM/DD/YYYY]
      #put in range for months (0..31) and days (01..12) and year must start with 2

      #check for valid date range
      raise StandardError.new('Checkout can\'t be before or the same as checkin.') if @checkout_date <= @checkin_date

      #assign range, pass it in to find available room for this range
      range = (checkin_date..checkout_date).to_a
      room = @rooms.find_available_room(range)
      raise StandardError.new("Fully booked for this date range. Try again.") if room == nil

      #create a reservation with this checkin_date, checkout_date and room number
      input = {checkin_date: checkin_date, checkout_date: checkout_date, room_number: room.room_number}
      reservation = Reservation.new(input)

      #add reservation to room
      room.add_reservation(reservation)

      #TO DO: maybe create room with checkout_date - 1 to make sure dont overlap??? (so pass in checkout_date -1 or update valid room method?)

    end

    #helper method for make_reservation
    def find_available_room(date_range)

      #return room if available one found, else return nil
      return @rooms.find { |room| room.is_available?(date_range) }
    end

    def add_reservation_to_list(reservation)
      @reservations << reservation
    end

    # As an administrator, I can access the list of all of the rooms in the hotel
    def list_available_rooms
      # date = Date.now()
      #return list of @rooms with details
      #if .include date
      #@reservations.each { |reservation| (reservation.checkin_date... reservation.checkout_date)}.include(date?)
      #return the reservation.room.room_number for the false ones
    end

    # As an administrator, I can access the list of reservations for a specific date
    def list_daily_reservations(date)
      #this will be the startdate -- or in the range
    end
    # As an administrator, I can get the total cost for a given reservation
    def get_total_cost(confirmation_id)
    end

  end

end
