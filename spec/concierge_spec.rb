require_relative 'spec_helper'

describe 'Lodging::Concierge class' do
  #reset CSV data
  before(:each) do
    CSV.open('data/all_hotel_rooms.csv', 'w', headers: true) do |csv|
      csv << ['room_number','cost','status','check_in','check_out']
    end

    CSV.open('data/reservations.csv', 'w', headers: true) do |csv|
      csv << ['room_number','cost','status','check_in','check_out']
    end
  end

  let(:concierge){
    Lodging::Concierge.new(10)
  }

  describe 'all rooms method' do
    it 'can view data in all_hotel_rooms csv file' do

      expect(concierge.all_rooms).must_be_instance_of Array
      expect(concierge.all_rooms.any? Hash).must_equal true
      expect(concierge.all_rooms.length).must_equal 10

    end
  end

  describe 'new reservation method' do

    it 'creates new reservations' do
      concierge.all_rooms

      concierge.new_reservation('Sept 9, 2018', 'Sept 12, 2018')

      first = concierge.all_rooms[0][:reserved_dates].first
      last = concierge.all_rooms[0][:reserved_dates].last
      status = concierge.all_rooms[0][:status]

      expect(status).must_equal 'unavailable'
      expect(first).must_equal Date.parse('Sept 9, 2018')
      expect(last).must_equal Date.parse('Sept 12, 2018')

    end

    it 'errors if invalid date is entered' do
      expect{concierge.new_reservation('August 7, 2019', 'August 28, 2018')}.must_raise ArgumentError
    end

  end

  describe 'reserved rooms method' do
    it 'errors if date argument not passed' do
      concierge.new_reservation('Sept 9, 2018', 'Sept 12, 2018')
      concierge.new_reservation('Sept 13, 2018', 'Sept 20, 2018')

      expect{concierge.reserved_rooms('forty-two')}.must_raise ArgumentError
      expect{concierge.reserved_rooms(4)}.must_raise TypeError
      expect{concierge.reserved_rooms('66')}.must_raise ArgumentError

    end

    it 'returns list of reservations that have date' do
      concierge.new_reservation('Sept 9, 2018', 'Sept 12, 2018') #room 1
      concierge.new_reservation('Sept 13, 2018', 'Sept 20, 2018') #room 2
      concierge.new_reservation('Sept 10, 2018', 'Sept 20, 2018') #room 3
      concierge.new_reservation('Sept 6, 2018', 'Sept 13, 2018') #room 4

      sept_12 = concierge.reserved_rooms('Sept 12, 2018')

      expect(sept_12.length).must_equal 3
      expect(sept_12[0][:room_number]).must_equal '1'
      expect(sept_12[1][:room_number]).must_equal '3'
      expect(sept_12[2][:room_number]).must_equal '4'

    end

  end

  describe 'receipt' do
    it 'calculates total cost for stay' do
      concierge.new_reservation('Sept 9, 2018', 'Sept 12, 2018') #room 1
      
      concierge.receipt(1)
    end
  end

end
