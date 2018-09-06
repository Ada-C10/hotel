require 'csv'
require 'date'
# The resevation class will likely exist in the hotel module
# the reservation class will contain an id, a list of room id's
# that are booked in the reservation, the reservation start date,
# the reservation end date
module Hotel
  class Reservation
    attr_reader :id, :guest_name, :included_rooms, :rsv_start, :rsv_end, :total_cost
    def initialize(id, guest_name, included_rooms, rsv_start, rsv_end)
      raise ArgumentError if rsv_end < rsv_start
      raise ArgumentError if included_rooms.empty?
      # must check nil first to stacktrace error
      raise ArgumentError if guest_name.nil? || guest_name.empty?

      @id = id # reservation id
      @guest_name = guest_name # name of guest holding reservation
      @included_rooms = included_rooms # array - list of rooms booked for reservation
      @rsv_start = Date.parse(rsv_start) # reservation start date
      @rsv_end = Date.parse(rsv_end) # reservation end data
      @status = :BASERATE # start w/ base rate, option to add BLOCKRATE for later dev
      # call methods to define variables
      @booked_dates = get_date_range_arr(@rsv_start, @rsv_end)
      @total_cost = get_total_cost(@included_rooms, @booked_dates, @status)

      # TODO: implement booking type for standard vs block booking ??? hmm
      # @booking_type = status # :BASERATE, :BLOCKRATE
    end

    # BookedDates = Struct.new(:rsv_start, :rsv_end) do
    # method to make an array of date ranges for reservation
    def get_date_range_arr(rsv_start, rsv_end)
      # TODO:
      (rsv_start...rsv_end).to_a.map { |day| day.to_s }
    end

    def get_total_cost(included_rooms, booked_dates, status)
      a = included_rooms.length
      b = booked_dates.length
      if status == :BASERATE
        total = a * b * 200.00
      else # block rate w/ discount
        total = (a * b * 200.00) * 1
      end
      return total
    end


    # method to list all reservations
    def self.all_reservations
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
        # binding.pry
      end
      # binding.pry
      return all_reservations
    end
    # method to find a reservation based on an inspect date 'insp_date'
    def self.find_all_reservations(insp_date)
      # found_reservations = []
      # @booked_dates.find { |date| date.insp_date == insp_date }
      # return
    end

  end #class end
end #module end