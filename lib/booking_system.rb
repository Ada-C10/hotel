module Hotel
  class BookingSystem
    attr_accessor :rooms, :reservations, :all_ids, :blocks

    def initialize
      @rooms = load_rooms
      @reservations = []
      @all_ids = []
      @blocks = []
    end

    def load_rooms
      rooms = []
      i = 1

      20.times do
        rooms << i
        i += 1
      end
      return rooms
    end

    def make_reservation(start_date, end_date)
      reservation = Hotel::Reservation.new(reservation_id: generate_id, room: assign_available_room(start_date, end_date), start_date: start_date, end_date: end_date, price_per_night: 200)
      @reservations << reservation
      # binding.pry
    end

    def make_block(start_date, end_date, number_of_rooms)
      if number_of_rooms > 5
        raise ArgumentError, "Cannot reserve more than 5 rooms"
      end

      id = generate_id

      block = Hotel::Block.new(block_id: id, number_of_rooms: number_of_rooms, start_date: start_date, end_date: end_date, discounted_price: 150)
      @blocks << block

      number_of_rooms.times do
        block_reservation = Hotel::BlockReservation.new(block_id: id,  reservation_id: nil, room: assign_available_room(start_date, end_date), start_date: start_date, end_date: end_date, discounted_price: 150)
        @reservations << block_reservation
      end
    end

    def make_block_reservation(block_id)
      block_reservation = find_block_reservation(block_id)
      block_reservation.reservation_id = generate_id
      return block_reservation
    end

    def assign_available_room(start_date, end_date)
      booked_rooms = []
      available_rooms = []
      @reservations.each do |reservation|
        if
          reservation.start_date < end_date && start_date < reservation.end_date
          booked_rooms << reservation.room
        end
      end
      all_rooms = load_rooms
      available_rooms = all_rooms - booked_rooms
      return available_rooms[0]
    end

    def search_reservations(start_date, end_date)
      reservations_within_date = []
      @reservations.each do |reservation|
        if
          reservation.start_date < end_date && start_date < reservation.end_date
          reservations_within_date << reservation
        end
      end
      # binding.pry
      return reservations_within_date
    end

    def find_reservation(reservation_id)
      reservation = @reservations.find { |reservation| reservation.reservation_id == reservation_id }
      return reservation
    end

    def find_block_reservation(block_id)
      block_reservation = @reservations.find { |block_reservation| block_reservation.block_id == block_id }
      return block_reservation
    end


    def generate_id
      reservation_id = rand(1..100000)
      check_id(reservation_id)
      @all_ids << reservation_id
      return reservation_id
    end

    def check_id(reservation_id)
      if @all_ids.include?(reservation_id)
        raise ArgumentError, "reservation_id already exists"
      end
    end

    def total_cost(reservation_id)
      reservation = find_reservation(reservation_id)
      nights = reservation.end_date - reservation.start_date
      total_cost = nights * reservation.price_per_night
      return total_cost
    end
  end
end
