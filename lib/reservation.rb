require 'date'
require 'pry'

class Reservation

attr_reader :start_date, :end_date, :cost, :reservation_id, :rooms

  @@reservation_ids = []

  def initialize(start_date, end_date, rooms = [])
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @checkout_date = @end_date - 1
    @rooms = []
    @cost = get_cost
    @reservation_id = create_reservation_id

    raise StandardError, 'Invalid date range!' if @start_date > @end_date

  end

  def add_rooms_reserved(room)
    @rooms << room
  end

  def get_cost
    if @rooms.length > 1
      return (((@end_date - @start_date).to_i ) * 200) * @rooms.length
    else
      return ((@end_date - @start_date).to_i ) * 200
    end
  end

  def create_reservation_id
    alpha = ('a'..'z').to_a
    id_generator = alpha[rand(26)] + alpha[rand(26)] + rand(100..999).to_s

    while @@reservation_ids.include? id_generator
      id_generator = alpha[rand(26)] + alpha[rand(26)] + rand(100..999).to_s
    end

    @@reservation_ids << id_generator
    return id_generator
  end

end
