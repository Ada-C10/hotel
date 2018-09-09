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
    def initialize(input)
      raise ArgumentError if Date.parse(input[:rsv_end]) < Date.parse(input[:rsv_start])
      raise ArgumentError if (input[:rsv_start]).empty?
      raise ArgumentError if (input[:rsv_end]).empty?
      # TODO: raise error if booking longer than x days?
      raise ArgumentError if input[:included_rooms].empty?
      # must check nil first to stacktrace error
      raise ArgumentError if input[:guest_name].nil? || input[:guest_name].empty?

      @id = input[:id].to_i # reservation id
      @guest_name = input[:guest_name] # name of guest holding reservation
      @included_rooms = input[:included_rooms] # array - list of rooms booked for reservation
      @rsv_start = Date.parse(input[:rsv_start]) # reservation start date
      @rsv_end = Date.parse(input[:rsv_end]) # reservation end data
      @status = :BASERATE # start w/ base rate, option to add BLOCKRATE for later dev
      # call methods to define booked dates and total cost instance variables
      @booked_dates = get_date_range_arr(Date.parse(input[:rsv_start]), Date.parse(input[:rsv_end]))
      @total_cost = get_total_cost(input[:included_rooms],
                                   Date.parse(input[:rsv_start]),
                                   Date.parse(input[:rsv_end]),
                                   @status)

      # TODO: implement booking type for standard vs block booking ??? hmm
      # @booking_type = status # :BASERATE, :BLOCKRATE
    end
    # def initialize(id, guest_name, included_rooms, rsv_start, rsv_end)
    #   raise ArgumentError if rsv_end < rsv_start
    #   # TODO: raise error if booking longer than x days?
    #   raise ArgumentError if included_rooms.empty?
    #   # must check nil first to stacktrace error
    #   raise ArgumentError if guest_name.nil? || guest_name.empty?
    #
    #   @id = id.to_i # reservation id
    #   @guest_name = guest_name # name of guest holding reservation
    #   @included_rooms = included_rooms # array - list of rooms booked for reservation
    #   @rsv_start = Date.parse(rsv_start) # reservation start date
    #   @rsv_end = Date.parse(rsv_end) # reservation end data
    #   @status = :BASERATE # start w/ base rate, option to add BLOCKRATE for later dev
    #   # call methods to define booked dates and total cost instance variables
    #   @booked_dates = get_date_range_arr(@rsv_start, @rsv_end)
    #   @total_cost = get_total_cost(@included_rooms, @rsv_start, @rsv_end, @status)
    #
    #   # TODO: implement booking type for standard vs block booking ??? hmm
    #   # @booking_type = status # :BASERATE, :BLOCKRATE
    # end

    # BookedDates = Struct.new(:rsv_start, :rsv_end) do
    # method to make an array of date ranges for reservation
    # date range up to but not including rsv_end
    def get_date_range_arr(rsv_start, rsv_end)
      (rsv_start...rsv_end).to_a.map { |day| day.to_s }
    end

    def get_total_cost(included_rooms, rsv_start, rsv_end, status)
      a = included_rooms.length
      b = (rsv_end - rsv_start).to_i
      if status == :BASERATE # calc w/ base rate $200/night
        total = a * b * 200.00
      else # block rate w/ discount
        total = (a * b * 200.00) * 1
      end
      return total
    end


    # # method to list all reservations
    # def self.load_reservations
    #   all_reservations = []
    #   reservations = CSV.open('data/reservations.csv', 'r',
    #                           headers: true, header_converters: :symbol)
    #                           .map {|line| line.to_h}
    #
    #   reservations.each do |reservation|
    #     all_reservations << Reservation.new(reservation[:id],
    #                                         reservation[:guest_name],
    #                                         (reservation[:included_rooms]).split(';')
    #                                                                       .map {|s| s.to_i},
    #                                         reservation[:rsv_start], reservation[:rsv_end])
    #   end
    #
    #   return all_reservations
    # end

  end #class end
end #module end