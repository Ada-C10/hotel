require_relative 'room'
require_relative 'reservation'
require_relative 'room_block'

module Hotel

  class ReservationManager

    VALID_ROOM_IDS = (1..20).to_a
    #RESERVATION_NAMING_CONVENTION = /^[A-Z]{3}+[\d]{5}/
    #BLOCK_NAMING_CONVENTION = /BLOCK+[\d]{5}/

    attr_reader :reservations, :rooms, :room_cost, :room_block_discount

    def initialize

      @room_cost = 200
      @room_block_discount = 0.8
      @reservations = []
      generate_room_ids(VALID_ROOM_IDS)
    end

    #helper method for make_reservation / finding one available room
    def find_available_room(date_range)

      @rooms.each() do |room|
        if room.is_available?(date_range)
          return room
        end
      end

      return "Hotel fully booked for this date range. Try a different date."
    end

    #helper method for making a reservation / calculating cost
    def calculate_total_cost(checkin_date, checkout_date, room_cost, room_block_discount = 1)

      total_cost = room_block_discount * room_cost.to_i * (Date.parse(checkout_date) - Date.parse(checkin_date))

      if total_cost <= 0
        raise ArgumentError.new('Total cost can\'t be $0 or less. Please give me a valid date range: MM/DD/YYYY and a room cost greater than 0.')
      end

      return total_cost.to_i
      #modified julian number #starts from midnight # .mjd #do I need?
    end

    #helper method for storing a reservation / adding it to the list
    def add_reservation_to_list(reservation)
      raise ArgumentError.new('Not a valid reservation.') if reservation.class != Hotel::Reservation
      @reservations << reservation
    end

    # helper method for making reservation / parsing the reservation data
    def parse_reservation_data(checkin_date, checkout_date, room_object, room_block_discount = 1)

      return { checkin_date: checkin_date, checkout_date: checkout_date,
        room_number: room_object.room_number, confirmation_id: generate_random_reservation_id,
        total_cost: calculate_total_cost(checkin_date, checkout_date, @room_cost, room_block_discount) }
    end

    #creates a reservation if there's an available room and adds to list
    def make_reservation(checkin_date, checkout_date, room_block = false, num_rooms = 1)

      if room_block == true
        return make_room_block(checkin_date, checkout_date, num_rooms, @room_block_discount)
      end

      #find room in range
      range = (Date.parse(checkin_date)..Date.parse(checkout_date)).to_a
      room = find_available_room(range) #error here

      #parse data into a form needed for reservation
      input = parse_reservation_data(checkin_date, checkout_date, room)

      #create a room reservation from our input
      reservation = Hotel::Reservation.new(input)

      #add new reservation to list of rooms and list of reservations in ReservationManager
      room.add_reservation(reservation)
      add_reservation_to_list(reservation)
      return reservation
    end

    # helper method for making room_block / parsing the room_block data
    def parse_room_block_data(checkin_date, checkout_date, num_rooms, room_block_discount)

      return { checkin_date: checkin_date, checkout_date: checkout_date,
        room_number: "BLOCK#{generate_random_block_id}",
        total_cost: calculate_total_cost(checkin_date, checkout_date, @room_cost),
        reservations: reservations, num_rooms: num_rooms}
    end

    def make_room_block(checkin_date, checkout_date, num_rooms = 2, room_block_discount = 1)
      reservations = []

      num_rooms.times.each do
        reservation = make_reservation(checkin_date, checkout_date)
        reservations  << reservation
      end

      block_data = parse_room_block_data(checkin_date, checkout_date, num_rooms, room_block_discount)

      return Hotel::RoomBlock.new(block_data)
    end

    # def make_reservation(checkin_date, checkout_date, room_block = false, num_rooms = 1, room_block_discount = 0)
    #   if room_block
    #     # make_block_reservations(checkin_date, checkout_date, num_rooms)
    #   else
    #     make_reservation(checkin_date, checkout_date)
    #   end
    # end

    # num_rooms.times do
    #   make_reservation(checkin_date, checkout_date, room_block = false, num_rooms = 1, room_block_discount = 0)
    # end


    #returns total cost for a given reservation
    def get_total_reservation_cost(given_confirmation_id)

      return @reservations.reduce(0) do |cost, reservation|
        if reservation.confirmation_id == given_confirmation_id.to_s
          cost + reservation.total_cost
        end
      end
    end

    #returns array of list of room numbers in all rooms
    def list_all_rooms_in_hotel

      return @rooms.map { |room| room.room_number }
    end

    #helper method for listing all available rooms
    def find_all_available_rooms(given_date_range)

      available_rooms = []

      @rooms.find_all do |room|
        if (room.is_available?(given_date_range))
          available_rooms << room.room_number
        end
      end

      return "Hotel fully booked for this date range. Try a different date." if available_rooms.empty?
      return available_rooms
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
    # won't return the reservation if checkout on is on the given_day
    def list_daily_reservations(given_date)

      given_date = Date.parse(given_date)
      daily_reservations = []

      @reservations.find_all do |reservation|
        if ((reservation.checkin_date..reservation.checkout_date).to_a - [reservation.checkout_date]).include?(given_date)
          daily_reservations << reservation.confirmation_id
        end
      end

      return "No reservations for #{given_date}." if daily_reservations.empty?
      return daily_reservations
    end


    private

    #private method to generate valid room ids for ReservationManager
    def generate_room_ids(room_ids)
      @rooms = room_ids.map do |room_id|
        Room.new(room_id)
      end
      raise StandardError.new('No rooms remaining to create.') if room_ids.empty?
    end

    #private method to generate reservation ids according to naming convention constant
    def generate_random_reservation_id

      return (('A'..'Z').to_a.sample(3) + (0..9).to_a.sample(5)).join
    end

    #private method to generate block ids according to naming convention constant
    def generate_random_block_id
      return ((0..9).to_a.sample(5)).join
    end

  end
end
