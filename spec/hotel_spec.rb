require_relative 'spec_helper'

describe 'initialize' do
  before do
    @my_hotel = Hotel.new
    @room_list = @my_hotel.room_list
  end

  it 'creates a new Hotel instance' do
    expect(@my_hotel).must_be_instance_of Hotel
  end

  it 'populates a list of 20 rooms in the hotel' do
    expect(@room_list).must_be_instance_of Array
    expect(@room_list.length).must_equal 20
  end

  it 'each item in the rooms array is a type of Room object' do
    expect(@room_list.all?{|item| item.is_a? Room}).must_equal true
  end
end

describe 'find room by number' do
  it 'can find a room instance given the room number' do
    my_hotel = Hotel.new
    room_5 = my_hotel.find_room_by_number(5)

    expect(room_5).must_be_instance_of Room
    expect(room_5.room_number).must_equal 5
  end
end

describe 'make reservation' do
  before do
    @my_hotel = Hotel.new
    @new_reservation = @my_hotel.make_reservation(Date.new(2010, 3, 4), Date.new(2010, 3, 8), 6)
  end
  it 'can create a new reservation with a start date, end date, and room number' do
    expect(@new_reservation).must_be_instance_of Reservation
    expect(@new_reservation.checkin_date).must_equal Date.new(2010, 3, 4)
    expect(@new_reservation.checkout_date).must_equal Date.new(2010, 3, 8)
    expect(@new_reservation.room_number).must_equal 6
    expect(@new_reservation.reservation_id).must_equal 6000156100
  end
  it 'adds the reservation to the rooms reservation array' do
    room_6 = @my_hotel.find_room_by_number(6)
    expect(room_6.reservations.length).must_equal 1
  end
  it 'raises an ArgumentError if the room is not available for that date range' do
    expect {
      @my_hotel.make_reservation(Date.new(2010, 3, 7), Date.new(2010, 3, 8), 6)
    }.must_raise ArgumentError
  end
  it 'allows a new reservation to start on the last day of an existing reservation' do
    @my_hotel.make_reservation(Date.new(2010, 3, 8), Date.new(2010, 3, 9), 6)
    room_6 = @my_hotel.find_room_by_number(6)
    expect(room_6.reservations.length).must_equal 2
  end
end

describe 'find reservations by date' do
  before do
    @my_hotel = Hotel.new
    @my_hotel.make_reservation(Date.new(2010, 3, 4), Date.new(2010, 3, 5), 6)
    @my_hotel.make_reservation(Date.new(2010, 3, 4), Date.new(2010, 3, 8), 7)
    @my_hotel.make_reservation(Date.new(2010, 2, 27), Date.new(2010, 3, 5), 8)
    @my_hotel.make_reservation(Date.new(2010, 5, 4), Date.new(2010, 5, 8), 9)
  end

  it 'returns an array of reservations that contain a specific date' do
    date = Date.new(2010, 3, 4)
    result = @my_hotel.find_reservations_by_date(date)
    expect(result).must_be_instance_of Array
    expect(result.length).must_equal 3

    date = Date.new(2010, 5, 5)
    result = @my_hotel.find_reservations_by_date(date)
    expect(result).must_be_instance_of Array
    expect(result.length).must_equal 1

    expect(result.all?{|item| item.is_a? Reservation}).must_equal true
  end

  it 'returns an empty array if no reservations exist on the given date' do
    date = Date.new(1999, 4, 4)
    result = @my_hotel.find_reservations_by_date(date)
    expect(result).must_be_instance_of Array
    expect(result.length).must_equal 0
  end
end

describe 'find available rooms' do
  before do
    @my_hotel = Hotel.new
    @my_hotel.make_reservation(Date.new(2010, 3, 4), Date.new(2010, 3, 5), 6)
    @my_hotel.make_reservation(Date.new(2010, 3, 4), Date.new(2010, 3, 8), 7)
    @my_hotel.make_reservation(Date.new(2010, 2, 27), Date.new(2010, 3, 5), 8)
    @my_hotel.make_reservation(Date.new(2010, 5, 4), Date.new(2010, 5, 8), 9)
  end
  it 'returns a list of room numbers given a date range' do
    room_list = @my_hotel.find_available_rooms(Date.new(2010, 3, 4), Date.new(2010, 5, 8))
    expect(room_list).must_equal [1, 2, 3, 4, 5, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
  end
  it 'says a room is available if someone is checking out on that day' do
    room_list = @my_hotel.find_available_rooms(Date.new(2010, 3, 5), Date.new(2010, 5, 8))
    expect(room_list.include?(6)).must_equal true
    expect(room_list.include?(8)).must_equal true
  end
  it 'returns an empty list if no rooms are available' do
    (1..20).each do |room_no|
      @my_hotel.make_reservation(Date.new(2010, 1, 1), Date.new(2010, 2, 2), room_no)
    end
    room_list = @my_hotel.find_available_rooms(Date.new(2010, 1, 5), Date.new(2010, 5, 8))
    expect(room_list).must_be_empty
  end
end

describe 'create room block' do
  before do
    @my_hotel = Hotel.new
    @block = @my_hotel.create_room_block(Date.new(2010, 3, 4), Date.new(2010, 5, 8), [1, 2, 3, 4, 5], 150, 'Block1')

  end

  it 'creates a new instance of a BlockReservation' do
    expect(@block).must_be_instance_of BlockReservation
  end

  it 'does not add the reservation to the list of hotel reservations' do
    expect(@my_hotel.reservations).must_be_empty
  end

  it 'adds the reservation to the list of hotel blocks' do
    expect(@my_hotel.blocks.length).must_equal 1
    expect(@my_hotel.blocks[0]).must_be_instance_of BlockReservation
  end


  it 'adds the reservation to each room and makes the rooms in the block unavailable during the given date range' do
    (1..5).each do |num|
      expect(@my_hotel.find_available_rooms(Date.new(2010, 3, 4), Date.new(2010, 5, 8))).wont_include num
    end
    expect(@my_hotel.find_available_rooms(Date.new(2010, 3, 4), Date.new(2010, 5, 8))).must_include 6
  end

  it 'prevents make_reservation from reserving a room in the block' do
    expect{
      @my_hotel.make_reservation(Date.new(2010, 3, 15), Date.new(2010, 5, 2), 3)
    }.must_raise ArgumentError
  end



end
