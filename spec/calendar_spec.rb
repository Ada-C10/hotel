require_relative 'spec_helper'
require 'pry'

describe Calendar do
  let(:calendar) {
    Calendar.new(20)
  }
  let(:manager) {
    BookingManager.new(calendar)
    # }
    # let(:reservation1) {
    #   Reservation.new('181202', '181204')
    # }
    # let(:reservation2) {
    #   Reservation.new('181203', '181206')
    # }
    # let(:reservation3) {
    #   Reservation.new('181205', '181206')
    # }
    # let(:reservation4) {
    #   Reservation.new('181204', '181206')
    }
  let(:list) {
    calendar.list_available_rooms(reservation1)
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
  let(:reservation4) {
    Reservation.new('181130', '181202')
  }
  let(:reservation5) {
    Reservation.new('181130', '181206')
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

  describe "#reservation_list" do
    before do
      manager.add_reservation(reservation1)
      manager.add_reservation(reservation1)
      manager.add_reservation(reservation2)
      manager.add_reservation(reservation3)
      manager.add_reservation(reservation4)
    end
    it "returns list of reserved rooms for provided date" do
      list = calendar.reservation_list('181203')
      expect(list.length).must_equal 3
      expect(list[0]).must_equal 1
      expect(list[2]).must_equal 3
    end
  end

  describe "#available_room?" do
    before do
      manager.add_reservation(reservation1)
    end
    it "returns false if room is reserved for all given dates" do
      expect(calendar.available_room?(1, reservation1)).must_equal false
    end
    it "returns true if room isn't reserved for any given dates" do
      expect(calendar.available_room?(1, reservation2)).must_equal true
        # expect(calendar.available_room?(1, reservation4)).must_equal true
    end
    it "returns false if room is reserved for any given dates" do
      expect(calendar.available_room?(1, reservation3)).must_equal false
      expect(calendar.available_room?(1, reservation5)).must_equal false
    end
  end

  describe "#list_available_rooms" do
    before do
      manager.add_reservation(reservation1)
    end
    it "returns array of available rooms" do
      expect(list).must_be_kind_of Array
      expect(list.length).must_equal 19
      expect(list.first).must_equal 2
    end
  end

end
# end
# end
# end
