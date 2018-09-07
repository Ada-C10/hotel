require 'date'

#a reservation class
module Hotel

  class Reservation

    attr_reader :checkin_date, :checkout_date, :total_cost, :confirmation_id, :room_number

    #initializes a reservation with date #MM/DD/YYYY
    def initialize(input)

      @checkin_date = Date.parse(input[:checkin_date])
      @checkout_date = Date.parse(input[:checkout_date])

      #TO DO: error checking / handling for date
      # begin
      #   raise StandardError.new() if ((@checkout_date <= @checkin_date) || @checkout_date != Date || @checkin_date != Date)
      #
      #   @checkin_date = Date.parse(input[:checkin_date])
      #   @checkout_date = Date.parse(input[:checkout_date])
      #
      # rescue
      #   # ...will cause this code to run
      #   puts 'Checkout can\'t be before or the same as checkin. Please enter valid date in the format: MM/DD/YYYY.'
      #   rescue_date()
      # end

      @room_number = input[:room_number].to_i
      @total_cost = input[:total_cost].to_i
      @confirmation_id = input[:confirmation_id]
    end

    #TO DO: rescue invalid date
    def rescue_date

      # rescue invalid date, ie if checkout_date before checkin_date or if invalid date like 2/31/18
      #if savable, save, else pass back to reservation_manager to give me better input
    end

  end
end
