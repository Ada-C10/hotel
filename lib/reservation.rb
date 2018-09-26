require 'date'
require 'pry'

class Reservation

attr_reader :start_date, :end_date, :cost, :id, :rooms, :checkout_date, :number_of_rooms

  @@reservation_ids = []

  def initialize(start_date, end_date, number_of_rooms, room_rate = 200)
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @checkout_date = @end_date - 1
    @number_of_rooms = number_of_rooms
    @rooms = []
    @room_rate = room_rate
    @cost = get_cost
    @id = create_reservation_id

    raise StandardError, 'Invalid date range!' if @start_date > @end_date

  end

  def add_rooms_reserved(room)
    @rooms << room
  end

  def get_cost
    return (((@end_date - @start_date).to_i ) * @room_rate) * @number_of_rooms
  end

  def dates_overlap?(start_a, end_a)
    return (start_a <= @checkout_date) && (end_a > @start_date)
  end

  def create_reservation_id
    id = id_generator

    while @@reservation_ids.include? id
      id = id_generator
    end

    @@reservation_ids << id
    return id
  end

  def id_generator
    alpha = ('a'..'z').to_a
    return id_generator = alpha[rand(26)] + alpha[rand(26)] + rand(100..999).to_s
  end

end
