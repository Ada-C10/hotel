require_relative 'lib_file_helper'

class Room
  attr_accessor :room_number, :dates_booked, :dates_held_for_block

  def initialize(room_number)
    @room_number = room_number.to_i
    # @dates_booked is a collection of date instances in which a specific room instance is booked for
    @dates_booked = []
    @dates_held_for_block = []
  end

  # Checking if a specific room instance is booked on a specific date
  def is_available?(formatted_date)

    if @dates_booked.include?(formatted_date)
      return false
    else
      return true
    end
  end

  def is_available_for_block?(formatted_date)
    if @dates_held_for_block.include?(formatted_date)
      return false
    else
      return true
    end
  end

  def price_per_night(room_type)
    if room_type == :standard
      return 200
    elsif room_type == :block
      return 150
    else
      raise ArgumentError.new("The room type entered is not valid")
    end
  end

  def update_dates_booked_for_room(array_of_dates)

    array_of_dates.each do |date|
      @dates_booked << date
    end

  end
end
