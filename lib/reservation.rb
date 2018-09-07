require 'csv'
require 'date'
# The resevation class will likely exist in the hotel module
# the reservation class will contain an id, a list of room id's
# that are booked in the reservation, the reservation start date,
# the reservation end date
module Hotel
  class Reservation
    attr_reader :id, :guest_name, :included_rooms, :rsv_start, :rsv_end,
                :total_cost, :booked_dates, :status
    def initialize(id, guest_name, included_rooms, rsv_start, rsv_end)
      raise ArgumentError if rsv_end < rsv_start
      # TODO: raise error if booking longer than x days?
      raise ArgumentError if included_rooms.empty?
      # must check nil first to stacktrace error
      raise ArgumentError if guest_name.nil? || guest_name.empty?

      @id = id.to_i # reservation id
      @guest_name = guest_name # name of guest holding reservation
      @included_rooms = included_rooms # array - list of rooms booked for reservation
      @rsv_start = Date.parse(rsv_start) # reservation start date
      @rsv_end = Date.parse(rsv_end) # reservation end data
      @status = :BASERATE # start w/ base rate, option to add BLOCKRATE for later dev
      # call methods to define booked dates and total cost instance variables
      @booked_dates = get_date_range_arr(@rsv_start, @rsv_end)
      @total_cost = get_total_cost(@included_rooms, @booked_dates, @status)

      # TODO: implement booking type for standard vs block booking ??? hmm
      # @booking_type = status # :BASERATE, :BLOCKRATE
    end

    # BookedDates = Struct.new(:rsv_start, :rsv_end) do
    # method to make an array of date ranges for reservation
    # date range up to but not including rsv_end
    def get_date_range_arr(rsv_start, rsv_end)
      (rsv_start...rsv_end).to_a.map { |day| day.to_s }
    end

    def get_total_cost(included_rooms, booked_dates, status)
      a = included_rooms.length
      b = booked_dates.length
      if status == :BASERATE # calc w/ base rate $200/night
        total = a * b * 200.00
      else # block rate w/ discount
        total = (a * b * 200.00) * 1
      end
      return total
    end


    # method to list all reservations
    def self.load_reservations
      all_reservations = []
      reservations = CSV.open('data/reservations.csv', 'r',
                              headers: true, header_converters: :symbol)
                              .map {|line| line.to_h}
      # binding.pry
      reservations.each do |reservation|
        # binding.pry
        all_reservations << Reservation.new(reservation[:id],
                                            reservation[:guest_name],
                                            (reservation[:included_rooms]).split(';')
                                                                          .map {|s| s.to_i},
                                            reservation[:rsv_start], reservation[:rsv_end])
      end

      return all_reservations
    end
    # # method to find a reservation based on an inspect date 'insp_date'
    # def self.find_reservations_by_date(inspect_date)
    #   # standardize input date
    #   search_date = Date.parse(inspect_date)
    #   # select all reservation instances that have booked dates that match
    #   # the inspect date
    #   found_reservations = Reservation.load_reservations.select do |reservation|
    #     reservation.booked_dates.include? search_date.to_s
    #   end
    #   found_reservations = 0 if found_reservations.empty?
    #   return found_reservations
    # end
    #
    # # method to find reservation based on id
    # def self.find_a_reservation(id)
    #   reservation = Reservation.load_reservations.find { |rsv| rsv.id == id }
    #   raise ArgumentError, 'ID does not exist' if reservation.nil?
    #   return reservation
    # end
    #
    # # method to return total cost based on reservation id
    # def self.get_reservation_total(id)
    #   rsv = find_a_reservation(id)
    #   total = rsv.total_cost
    #   return total
    # end

    # def self.find_available_rooms(inspect_date)
    #   # load reservations
    #   rooms = find_reservations_by_date(inspect_date)
    #   # all_rooms = Room.all
    #   if rooms == 0
    #      avail_rooms = (Room.all).map { |room| room.id}
    #   else
    #     # map booked rooms to new array - flatten it
    #     booked = (rooms.map {|rsv| rsv.included_rooms }).flatten
    #     # binding.pry
    #     # search all room instances for rooms that don't match
    #     rooms_arr = (Room.all).map { |room| room.id}
    #     avail_rooms = rooms_arr - booked
    #   end
    #   # binding.pry
    #   return avail_rooms
    # end

  end #class end
end #module end