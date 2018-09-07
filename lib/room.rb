require 'pry'
require 'date'
require_relative 'reservation'


class Room
  attr_reader :room_num, :rate, :reserve_dates

  def initialize(room_num)
    if room_num.to_i > 20 || room_num.to_i < 1
      raise ArgumentError
    else
      @room_num = room_num
      @rate = 200
      @reserve_dates = []

    end
  end

  def add_reserve_dates(new_reserve_dates)
    duplicated = @reserve_dates & new_reserve_dates
    if duplicated.length > 0
        raise ArgumentError, "Duplicated reservation"
    else
      @reserve_dates += new_reserve_dates
    end
  end
end
