require_relative 'reservation'
require 'date'
require 'pry'

class BlockRooms

attr_reader :start_date, :end_date, :cost, :block_id, :rooms_reserved, :checkout_date, :discounted_rate, :rooms_blocked

  @@block_ids = []

  def initialize(start_date, end_date, number_of_rooms, discounted_rate)
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @number_of_rooms = number_of_rooms
    @discounted_rate = discounted_rate
    @rooms_blocked = []
    @rooms_reserved = []
    @checkout_date = @end_date - 1
    @block_id = create_block_id

    raise StandardError, 'Invalid date range!' if @start_date > @end_date
  end

  def add_rooms_reserved(room)
    @rooms_reserved << room
  end

  def create_block_id
    id = block_id_generator

    while @@block_ids.include? id
      id = block_id_generator
    end

    @@block_ids << id
    return id
  end

  def block_id_generator
    alpha = ('a'..'z').to_a
    return id = alpha[rand(26)] + alpha[rand(26)] + rand(100..999).to_s
  end

  def add_rooms_blocked(room)
    @rooms_blocked << room
  end

end
