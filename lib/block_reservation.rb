require_relative 'reservation'
require 'date'
require 'pry'

class BlockReservation #< Reservation

attr_reader :start_date, :end_date, :cost, :reservation_id, :rooms_reserved, :checkout_date, :discounted_rate, :rooms_blocked

  @@reservation_ids = []

  def initialize(start_date, end_date, number_of_rooms, discounted_rate)
    # super(start_date, end_date, number_of_rooms)
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @number_of_rooms = number_of_rooms
    @discounted_rate = discounted_rate
    @cost = get_cost
    @rooms_reserved = []
    @rooms_blocked = []
    @checkout_date = @end_date - 1
    @reservation_id = create_reservation_id


    raise StandardError, 'Invalid date range!' if @start_date > @end_date

  end

  def add_rooms_reserved(room)
    @rooms_reserved << room
  end

  def get_cost
    return (((end_date - start_date).to_i ) * discounted_rate) * @number_of_rooms
  end

  def create_reservation_id
    # return super
  end

  def id_generator
    # return super
  end

  def add_rooms_blocked(room)
    @rooms_blocked << room
  end

end
