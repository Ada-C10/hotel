require_relative 'reservation.rb'
require_relative 'block_reservation'
module Hotel
  class BookingSystem
    attr_reader :rooms, :reservations
    def initialize(room_file = 'data/rooms.csv',
                   reservation_file = 'data/reservations.csv',
                   blockreservation_file = 'data/block_reservations.csv')
      @rooms = load_rooms(room_file)
      @reservations = load_reservations(reservation_file)
      @block_reservations = load_block_reservations(blockreservation_file)
    end


    def load_rooms(filename)
      all_rooms = []
      CSV.read(filename, headers: true).each do |line|
        input = {}
        input[:id] = line[0]
        input[:cost] = line[1]

        all_rooms << Room.new(input)
      end

      return all_rooms
    end

    def load_reservations(filename)
      all_reservations = []
      CSV.read(filename, headers: true)
                         .each do |line|
        input = {}
        input[:id] = line[0]
        input[:guest_name] = line[1]
        input[:included_rooms] = line[2].split(';').map { |num| num.to_i }
        input[:rsv_start] = line[3]
        input[:rsv_end] = line[4]

        all_reservations << Reservation.new(input)
      end

      return all_reservations
    end

    def load_block_reservations(filename)
      all_blocks = []
      CSV.read(filename, headers: true).each do |line|
        input = {}
        input[:id] = line[0]
        input[:guest_name] = line[1]
        input[:included_rooms] = line[2].split(';').map { |num| num.to_i }
        input[:rsv_start] = line[3]
        input[:rsv_end] = line[4]
        input[:group_name] = line[5]
        input[:room_qty] = line[6]

        all_blocks << BlockReservation.new(input)
      end

      return all_blocks
    end

    # method to find a reservation based on an inspect date 'insp_date'
    def find_reservations_by_date(inspect_date)
      # standardize input date
      search_date = Date.parse(inspect_date)
      # select all reservation instances that have booked dates that match
      # the inspect date

      found_reservations = @reservations.select do |reservation|
        reservation.booked_dates.include? search_date.to_s
      end
      # search through block id's if not found in standard reservations
      if found_reservations.empty?
        found_reservations = @block_reservations.select do |block_res|
          block_res.booked_dates.include? search_date.to_s
        end
      end

      # found_reservations = 0 if found_reservations.empty?

      return found_reservations
    end

    # method to find reservation based on id
    def find_a_reservation(id)
      reservation = @reservations.find { |rsv| rsv.id == id }
      raise ArgumentError, 'ID does not exist' if reservation.nil?
      return reservation
    end

    # method to return total cost based on reservation id
    def get_reservation_total(id)
      rsv = find_a_reservation(id)
      total = rsv.total_cost

      return total
    end


    def find_available_rooms(check_in, check_out)
      check_in = Date.parse(check_in)
      check_out = Date.parse(check_out)
      all_rooms_arr = (Room.all).map { |room| room.id}
      unavailable_rooms = []
      @reservations.each do |rsv|
        if (rsv.rsv_start > check_in && rsv.rsv_end < check_out) || \
           (rsv.rsv_start <= check_out && rsv.rsv_end > check_in)
          unavailable_rooms << rsv.included_rooms
        end
      end
      @block_reservations.each do |rsv|
        if (rsv.rsv_start > check_in && rsv.rsv_end < check_out) || \
           (rsv.rsv_start <= check_out && rsv.rsv_end > check_in)
          unavailable_rooms << rsv.included_rooms
        end
      end
      available_rooms = all_rooms_arr - unavailable_rooms.flatten

      return available_rooms
    end

    def make_a_reservation(guest, check_in, check_out, number_of_rooms = 1, status = :BASE)
      raise ArgumentError, 'At most 20 rooms available for booking at any time' if number_of_rooms > 20 || !(number_of_rooms.is_a? Integer)
      open_rooms = find_available_rooms(check_in, check_out).first(number_of_rooms)
      raise StandardError, 'No rooms available' if open_rooms == []
      res_id = (@reservations.last).id + 1
      new_res = Hotel::Reservation.new(id: res_id, guest_name: guest,
                                       included_rooms: open_rooms,
                                       rsv_start: check_in,
                                       rsv_end: check_out,
                                       status: status)

      @reservations << new_res

      return new_res
    end

    def make_a_block(group_name, check_in, check_out, number_of_rooms, status = :BLOCK)
      open_block = find_available_rooms(check_in, check_out).first(number_of_rooms)
      res_id = (@block_reservations.last).id + 1
      new_block = Hotel::BlockReservation.new(id: res_id, guest_name: 'pending',
                                              group_name: group_name,
                                              included_rooms: open_block,
                                              rsv_start: check_in,
                                              rsv_end: check_out,
                                              status: status,
                                              room_qty: number_of_rooms)

      @block_reservations << new_block

      return new_block
    end

    def make_a_block_reservation(group_name)
      block_reservation = @block_reservations.find { |rsv| rsv.group_name == group_name }

    end


  end # class
end # module