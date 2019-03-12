require 'pry'
require 'date'
require_relative 'reservation'
require_relative 'room'


class Block
  attr_reader :discount, :block_name, :rooms, :reservations, :start_date, :end_date, :rooms_available

  def initialize(name, room_id_list, start_date, end_date, discounted_rate)
    @discount = discounted_rate
    @block_name = name
    @rooms = []
    @reservations = []
    @start_date = start_date
    @end_date = end_date
    @rooms_available = []

    room_id_list.each do |i|
      room_new = create_room(i)
      @rooms << room_new
      @rooms_available << room_new
    end
  end

  def calculate_cost(reservation_id)
    return find_reservation(reservation_id).reserve_cost * (1 - @discount)
  end

  def make_reservation(customer_name)

    if @rooms_available == []
      raise ArgumentError, "No room available at this time."
    else
      room = @rooms_available.pop
    end

    result = create_reservation(customer_name, room, @start_date, @end_date)
    @reservations << result

    return result
  end


  private

  def create_reservation(customer_name, room, start_date, end_date)
    return Reservation.new(customer_name, room, start_date, end_date)
  end

  def create_room(id)
    return Room.new(id)
  end

  def find_reservation(id)

    return @reservations.find {|reserve| reserve.id == id }
  end

end
