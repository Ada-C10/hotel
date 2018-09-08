require_relative 'reservation.rb'
module Hotel
  class BookingSystem
    def initialize
      @reservations = Hotel::Reservation.load_reservations
    end
    # method to find a reservation based on an inspect date 'insp_date'
    def self.find_reservations_by_date(inspect_date)
      # standardize input date
      search_date = Date.parse(inspect_date)
      # select all reservation instances that have booked dates that match
      # the inspect date
      # found_reservations = Hotel::Reservation.load_reservations.select do |reservation|
      #   reservation.booked_dates.include? search_date.to_s
      # end
      found_reservations = @reservations.select do |reservation|
        reservation.booked_dates.include? search_date.to_s
      end

      found_reservations = 0 if found_reservations.empty?
      return found_reservations
    end

    # method to find reservation based on id
    def self.find_a_reservation(id)
      reservation = Hotel::Reservation.load_reservations.find { |rsv| rsv.id == id }
      raise ArgumentError, 'ID does not exist' if reservation.nil?
      return reservation
    end

    # method to return total cost based on reservation id
    def self.get_reservation_total(id)
      rsv = find_a_reservation(id)
      total = rsv.total_cost
      return total
    end


    def self.find_available_rooms(check_in, check_out)
      check_in = Date.parse(check_in)
      check_out = Date.parse(check_out)
      all_rooms_arr = (Room.all).map { |room| room.id}
      unavailable_rooms = []
      # load reservations
      current_reservations = Hotel::Reservation.load_reservations
      # binding.pry
      current_reservations.each do |rsv|
        if (rsv.rsv_start > check_in && rsv.rsv_end < check_out) || \
           (rsv.rsv_start <= check_out && rsv.rsv_end > check_in)
          unavailable_rooms << rsv.included_rooms
        end
      end
      available_rooms = all_rooms_arr - unavailable_rooms.flatten

      return available_rooms
    end

    def self.make_a_reservation(guest, check_in, check_out, number_of_rooms = 1)
      open_rooms = find_available_rooms(check_in, check_out).first(number_of_rooms)
      res_id = @reservations.length
      new_res = Hotel::Reservation.new(res_id, guest, open_rooms, check_in, check_out)
      @reservations << new_res
      return new_res
    end


  end # class
end # module