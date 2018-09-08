require_relative 'reservation'

module Hotel
  class Block_Room < Reservation
    attr_reader :name, :room_number, :check_in_date, :check_out_date, :nights_of_stay, :block_name, :block_discount
    attr_accessor :block_reservation_status

    BLOCK_RESERVATION_STATUS = [:AVAILABLE, :BOOKED]

    def initialize(input)
      super
      @block_name = input[:block_name]
      @block_discount = input[:block_discount]
      @block_reservation_status = :AVAILABLE
    end

  end
end
