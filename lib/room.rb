require_relative 'reservation'

class Room
  attr_reader :id
  attr_accessor :unavailable_dates

  def initialize(id)
    @id = id
    @unavailable_dates = []
  end


  def self.create(number_rooms)
    rooms = []
    number_rooms.times do |room_number|
      rooms << Room.new(room_number + 1)
    end
    return rooms
  end

  def self.list
    return ObjectSpace.each_object(self).to_a
  end

  def is_available?(check_in,check_out)
    if 
    # if date_range.all? { |date| unavailable_dates.include?(date) }
    #   return 0
    # else
    #   return self.id
    # end
  end

  def add_unavailable_dates(check_in,check_out)
    dates = {}
    dates[:check_in] = check_in
    dates[:check_out] = check_out
    unavailable_dates << dates
    unavailable_dates.sort_by! { |ranges| ranges[:check_in] }
  end



end
