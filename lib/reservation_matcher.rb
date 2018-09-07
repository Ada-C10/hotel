module Hotel

  class ReservationMatcher

    VALID_ROOMS = (1..20).to_a

    attr_reader :reservations, :rooms

    def initialize
      @reservations = []
      @rooms = VALID_ROOMS.length.times.map { |room| Room.new(generate_room_id) }
      raise StandardError.new('Created too many rooms.') if VALID_ROOMS.empty?
      #where to put above? 
    end

    # As an administrator, I can reserve a room for a given date range
    def make_reservation(checkin_date, checkout_date)

      #given valid check_in --> do thingy
      #given invalid -- throw error or rescue?

      #assign range, pass it in to find available room for this range
      range = (checkin_date..checkout_date).to_a
      room = @rooms.find_available_room(range)
      raise StandardError.new("Fully booked for this date range. Try again.") if room == nil

      #create a reservation with this checkin_date, checkout_date and room number
      input = {checkin_date: checkin_date, checkout_date: checkout_date, room_number: room.room_number}
      reservation = Hotel::Reservation.new(input) #wrap this in begin rescue #put in what happens if not created


      #add reservation to room
      room.add_reservation(reservation)

    end

    #helper method for make_reservation
    def find_available_room(date_range)

      #return room if available one found, else return nil
      # return @rooms.find { |room| room.is_available?(date_range) }
    end

    def add_reservation_to_list(reservation)
      @reservations << reservation
    end

    # As an administrator, I can access the list of all of the rooms in the hotel
    #not sure what this should do
    #room object I guess
    #rooms with resrvation numbers
    def list_all_rooms
      # return @rooms.each do |room|
      #   room.id + ":" + room.reservations.map { |reservation| reservation.confirmation_id }
      # end
    end

    def list_rooms_available_today
      # date_range_today = [Date.today()]
      # available_rooms = @rooms.map do |room| if room.is_available?
      # use reduce
      #
      # intro = "Rooms available for today: "
      #
      # return @rooms.reduce(intro) do |statement, room|
      #   if room.is_available?
      #     statement + ", " room
      #   end
      # end

      # # print_available_rooms(available_rooms)
    end

    # #helper method for list_available_rooms
    # def print_available_rooms(available_rooms)
    # end

    # As an administrator, I can access the list of reservations for a specific date
    def list_daily_reservations(date)
      #date valid checking TO DO

      # intro = "Reservations on #{date}: "
      # date = Date.parse(date)
      #
      # return @reservations.reduce(intro) do |statement, reservation|
      #   if reservation.date == date
      #     statement + ", " + reservation.confirmation_id
      #   end
      # end

    end

    # As an administrator, I can get the total cost for a given reservation
    def get_total_cost(confirmation_id)
    end

    private

    def generate_room_id
      VALID_ROOMS.pop()
    end

  end

end
