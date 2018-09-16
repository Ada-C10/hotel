require 'date'

module Hotel
  class HotelRooms
    attr_reader :rooms, :reservations

    def initialize
      @rooms = [:rooms]
      # fill in hotel rooms
      @reservations = {}
      set_up_rooms #calling this method
      set_up_reservations #calling this method
    end


  def set_up_rooms
    #creates list of hotel rooms
    19.times do |room_number|
      data = {}
      data[:room_number] = (room_number + 1)
      @rooms << Hotel::Room.new(data)
    end
      return @rooms
  end

  def list_rooms #outputs list of rooms
    return @rooms
  end

  def set_up_reservations #sets reservation's key to room #s
    @reservations = {}
    @reservations.each do |key, value|
      @reservations[key] = @rooms
    end
    return @reservations
  end
end 
