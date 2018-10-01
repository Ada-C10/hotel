

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
    new_res_dates = (check_in...check_out).to_a
    unavailable_dates.each do |reservation|
      reservation = (reservation[:check_in]...reservation[:check_out]).to_a
      if new_res_dates.include?(reservation.first) || reservation.include?(new_res_dates.first)
        return false
      end
    end
    return true
  end

  def add_unavailablity(check_in,check_out)
    
    dates = {}
    dates[:check_in] = check_in
    dates[:check_out] = check_out

    unavailable_dates << dates
    unavailable_dates.sort_by! { |ranges| ranges[:check_in] }
  end




end
