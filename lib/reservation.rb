require 'date'

#a reservation class
module Hotel

  class Reservation

    attr_reader :checkin_date, :checkout_date, :total_cost, :confirmation_id, :room_number

    ROOM_COST = 200
    NAME_REGEXP = /^[A-Z]{3}+[\d]{5}/

    #initializes a reservation with date #MM/DD/YYYY
    def initialize(input)

      #TO DO: check for valid date input
      #how to check invalid dates as strings? #USE REGEX!!!! [MM/DD/YYYY]
      #put in range for months (0..31) and days (01..12) and year must start with 2
      #RESCUE THIS BY ASKING USER TO ENTER VALID INPUT? OR NEXT?

      #room number or room object?

      #throw error if not valid dates and rescue? use builtin date class method to check date object
      #begin
      @checkin_date = Date.parse(input[:checkin_date])
      @checkout_date = Date.parse(input[:checkout_date])
      raise StandardError.new('Checkout can\'t be before or the same as checkin.') if @checkout_date <= @checkin_date
      #add chck valid Date class

      #rescue StandardError("Not a valid date. Try this format: MM/DD/YYYY")

      @room_number = input[:room_number]

      @confirmation_id = generate_random_id
      @total_cost = calculate_total_cost

      #as method validate --> raise something if conditions not met, and cant fix
      #now reservation manager has to rescue or someone higher up has to manage
      #if problem still cant be fixed, then raise
      #raise and rescue way to communicate up call stack

    end

    def calculate_total_cost
      return ROOM_COST * (@checkout_date - @checkin_date)
      #modified julian number #starts from midnight # .mjd #do I need?
    end

    private

    def generate_random_id
      return (Array('A'..'Z').sample(3) + Array(0..9).sample(5)).join
    end

  end

end
