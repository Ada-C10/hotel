require 'pry'
require 'date'
require_relative 'reservation'


class Room
  attr_reader :room_num, :rate, :reservations

  def initialize(room_num)
    if room_num.to_i > 20 || room_num.to_i < 1
      raise ArgumentError
    else
      @room_num = room_num
      @rate = 200
      @reservations = []

    end
  end

  # def add_reservation(new_reservation)
  #   if new_reservation.class != Reservation
  #       raise ArgumentError, "A reservation was not provided"
  #   end
  #   @reservations.each do |item|
  #     if item == new_reservation
  #       raise ArgumentError, "Duplicated reservation"
  #     end
  #   end
  #   @reservations << new_reservation
  # end
end
