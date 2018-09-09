require_relative 'spec_helper'
require 'pry'

describe Calendar do
  let(:calendar) {
    Calendar.new(20)
  }
  let(:reservation1) {
    Reservation.new('181202', '181204')
  }
  let(:reservation2) {
    Reservation.new('181204', '181206')
  }
  let(:reservation3) {
    Reservation.new('181203', '181204')
  }
  let(:list) {
    calendar.list_available_rooms(reservation1)
  }

  describe "#initalize" do
    it "can be instantiated" do
      expect(calendar).must_be_kind_of Calendar
    end
    it "stores rooms and room_assignments" do
      expect(calendar).must_respond_to :rooms
      expect(calendar).must_respond_to :room_assignments
    end
    it "creates accurate array of rooms" do
      expect(calendar.rooms[-1]).must_equal 20
      expect(calendar.rooms).must_be_kind_of Array
      expect(calendar.rooms[0]).must_equal 1
    end
    it "creates accurate room_assignments hash" do
      expect(calendar.room_assignments).must_be_kind_of Hash
      expect(calendar.room_assignments.keys).must_equal calendar.rooms
      calendar.room_assignments.values.each do |v|
        expect(v).must_be_kind_of Array
        expect(v).must_be_empty
      end
    end
  end

  describe "#available_room?" do
    before do
      calendar.add_reservation(reservation1)
    end
    it "returns false if room is reserved for given dates" do

      # binding.pry
      expect(calendar.available_room?(1, reservation1)).must_equal false
    end
    it "returns true if room isn't reserved for given dates" do
      expect(calendar.available_room?(1, reservation2)).must_equal true
      # expect(calendar.available_room?(1, @reservation4)).must_equal false
    end
  end

  describe "#list_available_rooms" do
    before do
      calendar.add_reservation(reservation1)
    end
    it "returns array of available rooms" do
      expect(list).must_be_kind_of Array
      expect(list.length).must_equal 19
      expect(list.first).must_equal 2
    end
  end

  describe "#add_reservation" do
    before do
      3.times do
        calendar.add_reservation(reservation1)
      end
    end
    it "adds all reservation dates to first available room" do
      expect(calendar.room_assignments[1]).must_equal reservation1.get_all_dates
      expect(calendar.room_assignments[2]).must_equal reservation1.get_all_dates
      expect(calendar.room_assignments[3]).must_equal reservation1.get_all_dates
    end
    it "returns 'Added!' message" do
      expect(calendar.add_reservation(reservation1)).must_equal "Added!"
    end
  end
end
  # end
  # end
