require_relative 'reservation'

module Hotel
  class Block_Room < Reservation
    attr_reader :name, :room_number, :check_in_date, :check_out_date, :nights_of_stay, :block_name, :block_discount

    def initialize(input)
      super
      @block_name = input[:block_name]
      @block_discount = input[:block_discount]
    end

  end
end
