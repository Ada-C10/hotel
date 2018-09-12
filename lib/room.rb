require 'pry'
# require 'Date'

module Hotel
  class Room
    attr_reader :id
    attr_accessor :reservations

    def initialize(number)
      @id = number
      @reservations = [] #bookings - both res/block
      #define room as physical space
    end
    #create helper methods that return boolean values - in reservmgr - create loop methods that take helper method booleans and creates an array
    #  def self.find_room(id)
    #    if room.id == id
    #      return room
    #    end
    # end
    #
    # def find_reservation(date)
    #   date = Date.parse(date)
    #   return self.date_range.include? date
    # end


    def is_booked?(check_in, check_out)
      check_in = Date.parse(check_in)
      check_out = Date.parse(check_out)
      check_dates = check_in...check_out
      return false if self.reservations.length == 0
      self.reservations.each do |reservation|
        if reservation.date_range.cover?(check_dates)
          return true
        elsif reservation.overlaps?(check_in, check_out)
          return true
        end
      end
      return false
    end

  end
end
