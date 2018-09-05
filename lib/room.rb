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
end
