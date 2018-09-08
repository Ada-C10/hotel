require_relative 'room'
require_relative 'reservation'

module Hotel

  class ReservationManager

    VALID_ROOM_IDS = (1..20).to_a
    ROOM_COST = 200
    RESERVATION_NAMING_CONVENTION = /^[A-Z]{3}+[\d]{5}/

    attr_reader :reservations, :rooms, :room_cost

    def initialize

      @room_cost = 200
      #room cost convention with regex?
      @reservations = []
      generate_room_ids(VALID_ROOM_IDS)
    end

    #helper method for make_reservation
    def find_available_room(date_range)

      #return room if available one found, else return nil
      return @rooms.find do |room|
        raise StandardError.new("Hotel fully booked for this date range. Try a different date.") if nil
        room.is_available?(date_range)
      end
    end

    #helper method for make_reservation
    def calculate_total_cost(checkin_date, checkout_date, room_cost)
      total_cost = room_cost.to_i * (Date.parse(checkout_date) - Date.parse(checkin_date))
      if total_cost <= 0
        raise ArgumentError.new('Total cost can\'t be $0 or less. Please give me a valid date range: MM/DD/YYYY and a room cost greater than 0.')
      end
      return total_cost
      #modified julian number #starts from midnight # .mjd #do I need?
    end

    #helper method for make_reservation
    def add_reservation_to_list(reservation)
      raise ArgumentError.new('Not a valid reservation.') if reservation.class != Hotel::Reservation
      @reservations << reservation
    end

    def load_reservations(checkin_date, checkout_date)
      range = (Date.parse(checkin_date)..Date.parse(checkout_date)).to_a
      room = @rooms.find_available_room(range)

      input = { checkin_date: checkin_date, checkout_date: checkout_date,
        room_number: room.room_number, confirmation_id: generate_random_reservation_id,
        room_cost: calculate_total_cost(checkin_date, checkout_date, @room_cost) }
        
    end

    def make_reservation(checkin_date, checkout_date)

#load data and do the things
    input = load_reservations(checkout_date, check_in_date)

    #create a reservation with this checkin_date, checkout_date and room number
    reservation = Hotel::Reservation.new(input)

    #add new reservation to list and respective rooms in hotel
    room.add_reservation(reservation)
    add_reservation_to_list(reservation)
    end

    #returns total cost for a given reservation
    def get_total_cost(given_confirmation_id)
      @reservations.each do |reservation|
        if reservation.confirmation_id == given_confirmation_id
          return reservation.total_cost
        end
      end
    end

    #returns array of list of room numbers in all rooms
    def list_all_rooms_in_hotel

      return @rooms.map { |room| room.room_number }
    end

    #helper method for finding available rooms
    def find_all_available_rooms(date_range)

      #return rooms in array if available one found, else return nil
      return @rooms.find_all do |room|
        raise StandardError.new("Hotel fully booked for this date range. Try a different date.") if nil
        room.is_available?(date_range)
      end
    end

    #returns array of rooms available today
    def list_rooms_available_today

      return find_all_available_rooms([Date.today()])
    end

    #returns array of rooms available for a given date
    def list_available_rooms(given_date_range)

      return find_all_available_rooms(given_date_range)
    end

    # returns an array of the list of reservations for a specific date
    def list_daily_reservations(given_date)
      given_date = Date.parse(given_date)

      return @reservations.map do |reservation|
        if reservation.date == given_date
          reservation.confirmation_id
        end
      end
    end

    #prints array of list of room numbers in all rooms
    # def list_all_rooms_in_hotel
    #   intro = "Room list: \n"
    #   return @rooms.reduce(intro) do |statement, room|
    #     statement + room.room_number
    #   end
    # end

    # #returns string of rooms available for a given date
    # def print_available_rooms(given_date_range)
    #
    #   available_rooms = find_all_available_rooms(given_date_range)
    #
    #   intro = "Rooms available for today: \n"
    #
    #   return available_rooms.reduce(intro) do |statement, room|
    #     if room.is_available?
    #       statement + ", " + room
    #     end
    #   end
    # end

    # #returns string of rooms available today
    # def print_rooms_available_today
    #
    #   available_rooms = find_all_available_rooms([Date.today()])
    #
    #   intro = "Rooms available for today: \n"
    #
    #   return available_rooms.reduce(intro) do |statement, room|
    #     if room.is_available?
    #       statement + ", " + room
    #     end
    #   end
    # end

    # returns a string of the list of reservations for a specific date
    # def print_daily_reservations(given_date)
    #
    #   "Reservations for #{given_date}: \n"
    #   given_date = Date.parse(given_date)
    #
    #   return @reservations.reduce(intro) do |statement, reservation|
    #     if reservation.date == given_date
    #       statement +  ", " + reservation.confirmation_id
    #     end
    #   end
    # end

    private

    #private method to generate valid room ids for this hotel
    def generate_room_ids(room_ids)
      @rooms = room_ids.map do |room_id|
        Room.new(room_id)
      end
      raise StandardError.new('No rooms remaining to create.') if room_ids.empty?
    end

    #private method to generate valid reservations for this hotel
    def generate_random_reservation_id
      return (Array('A'..'Z').sample(3) + Array(0..9).sample(5)).join
    end

  end
end
