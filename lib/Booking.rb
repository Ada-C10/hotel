class Booking
  # manages reservations
    # Will have most methods
    # Makes a reservation - Have booking figure it out
  attr_reader :rooms

  def initialize
    # Creating 20 rooms
    @rooms = []
    i = 1
    20.times do
      @rooms << Room.new(i, [])
      i += 1
    end
  end

  def list_all_rooms
    return @rooms
  end

  # Find room helper method
  def find_room(room_number)
    return @rooms.find { |room| room.room_number == room_number }
  end

  # TODO Can reserve a room for a given date range

  # TODO Can access the list of reservations for given date

  # TODO Can get the total cost for a given reservation

  # TODO Can view a list of rooms that are not reserved for a given date range

  # TODO Can reserve an available room for a given date range


  def add_reservation
    # Adds reservation to rooms array of reservations
    # Validate if room has availability for the date range given
    # Can add a reservation check in on days where another person is checking out
  end

end
