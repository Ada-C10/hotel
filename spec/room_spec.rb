require_relative 'spec_helper'

describe 'room class' do
  #to clear CSV file before each test
  before(:each) do
    CSV.open('data/all_hotel_rooms.csv', 'w', headers: true) do |csv|
      csv << ['room_number','cost','status', 'reserved_dates']
    end

    CSV.open('data/reservations.csv', 'w', headers: true) do |csv|
      csv << ['room_number','cost','status','check_in','check_out']
    end
  end

  describe 'initialize' do
    it 'creates a new instance of room' do
      new_room = Lodging::Room.new(3, 250)

      expect(new_room).must_be_instance_of Lodging::Room
      expect(new_room.room_number).must_equal 3
      expect(new_room.cost).must_equal 250
      expect(new_room.status).must_equal :available
    end
  end

  it 'adds each new instance of room into csv file' do
    Lodging.create_rooms(5)

    rooms = CSV.read('data/all_hotel_rooms.csv', headers: true)

    expect(rooms).must_be_instance_of CSV::Table
    expect(rooms.length).must_equal 5
  end

  describe 'available room' do

    it 'returns CSV of available room' do
      Lodging.create_rooms(5)

      expect(Lodging::Room.available_room).must_be_instance_of CSV
    end
  end

end
