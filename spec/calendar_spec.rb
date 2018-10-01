require_relative 'spec_helper'

describe Calendar do
  let(:calendar) {
    Calendar.new(20)
  }
  let(:manager) {
    BookingManager.new(calendar)
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
  let(:block2) {
    Block.new('181202', '181204', 2)
  }
  let(:block3) {
    Block.new('181204', '181206', 3)
  }
  let(:block4) {
    Block.new('181129', '181201', 4)
  }
  let(:block5) {
    Block.new('181203', '181204', 5)
  }
  let(:block6) {
    Block.new('181201', '181205', 5)
  }
  let(:block7) {
    Block.new('181202', '181203', 4)
  }
  let(:block8) {
    Block.new('181206', '181210', 3)
  }
  let(:block9) {
    Block.new('181206', '181208', 5)
  }

  describe "#initalize" do
    it "can be instantiated" do
      expect(calendar).must_be_kind_of Calendar
    end
    it "creates accurate array of rooms" do
      expect(calendar.rooms).must_be_kind_of Array
      expect(calendar.rooms[-1]).must_equal calendar.rooms.length
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

  describe "#add_reservation" do
    before do
      calendar.add_reservation(reservation1)
      calendar.add_reservation(reservation2)
      calendar.add_reservation(reservation3)
      calendar.add_reservation(reservation4)
      calendar.add_reservation(reservation5)
    end
    it "adds all reservation dates to first available room" do
      expect(calendar.room_assignments[1]).must_equal reservation1.get_all_dates + reservation2.get_all_dates + reservation4.get_all_dates

      expect(calendar.room_assignments[2]).must_equal reservation3.get_all_dates

      expect(calendar.room_assignments[3]).must_equal reservation5.get_all_dates
    end
    it "returns assigned room" do
      expect(calendar.add_reservation(reservation1)).must_equal 4
    end
    it "raises exception if no rooms available" do
      17.times do
        calendar.add_reservation(reservation1)
      end
      expect{calendar.add_reservation(reservation1)}.must_raise StandardError
    end
    it "correctly adds reservation dates when blocks are on calendar" do
      calendar.add_block(block2)

      expect(calendar.add_reservation(reservation3)).must_equal 6
      expect(calendar.room_assignments[6]).must_equal reservation3.get_all_dates
    end
  end

  describe "#add_block" do
    before do
      calendar.add_reservation(reservation1)
      calendar.add_reservation(reservation2)
      calendar.add_reservation(reservation3)
      calendar.add_reservation(reservation4)
      calendar.add_reservation(reservation5)
      calendar.add_block(block2)
      calendar.add_block(block7)
    end
    it "returns array of block rooms" do
      expect(calendar.add_block(block8)).must_equal [1, 2, 3]
    end
    it "raises exception if not enough available rooms" do
      4.times do
        calendar.add_block(block9)
      end

      expect{calendar.add_block(block9)}.must_raise StandardError
    end
    it "adds rooms hash to block object" do
      calendar.add_block(block8)

      expect(block8.rooms).must_be_kind_of Hash
      expect(block8.rooms.keys).must_equal [1, 2, 3]
      expect(block8.rooms.values).must_equal [:available, :available, :available]
    end
    it "adds block dates to calendar as array" do
      before = calendar.room_assignments[1].length

      calendar.add_block(block8)

      expect(calendar.room_assignments[1].length).must_equal before + 1
      expect(calendar.room_assignments[1].length).wont_equal before + block8.get_all_dates.length
      expect(calendar.room_assignments[1].include? block8.get_all_dates).must_equal true
    end
    it "adds all reservation dates to all block rooms" do
      expect(calendar.room_assignments[4][0]).must_equal block2.get_all_dates
      expect(calendar.room_assignments[4][0].length).must_equal block2.number_of_nights
      expect(calendar.room_assignments[5][0]).must_equal block2.get_all_dates
      expect(calendar.room_assignments[5][0].length).must_equal block2.number_of_nights
    end
  end

  describe "#reservations" do
    before do
      calendar.add_reservation(reservation1)
      calendar.add_reservation(reservation1)
      calendar.add_reservation(reservation2)
      calendar.add_reservation(reservation3)
      calendar.add_reservation(reservation4)
    end
    it "returns list of reserved rooms for given date" do
      reservations = calendar.reservations('181203')

      expect(reservations.length).must_equal 3
      expect(reservations[0]).must_equal 1
      expect(reservations[2]).must_equal 3
    end
    it "returns accurate list when blocks are on calendar" do
      calendar.add_block(block2)
      calendar.add_block(block3)
      calendar.add_block(block4)

      reservations = calendar.reservations('181130')

      expect(reservations.length).must_equal 5
      (1..5).each do |i|
        expect(reservations[i - 1]).must_equal i
      end
    end
  end

  describe "#available_room?" do
    before do
      calendar.add_reservation(reservation1)
      calendar.add_block(block2)
    end
    it "returns false if room is reserved for all given dates" do
      expect(calendar.available_room?(1, reservation1)).must_equal false
    end
    it "returns false if block is reserved for all given dates" do
      expect(calendar.available_room?(2, block2)).must_equal false
    end
    it "returns true if room isn't reserved for any given dates" do
      expect(calendar.available_room?(1, reservation2)).must_equal true
      expect(calendar.available_room?(1, reservation4)).must_equal true
    end
    it "returns true if block isn't reserved for any given dates" do
      (1..3).each do |i|
        expect(calendar.available_room?(i, block3)).must_equal true
      end
      (1..4).each do |i|
        expect(calendar.available_room?(2, block4)).must_equal true
      end
    end
    it "returns false if room is reserved for any given dates" do
      expect(calendar.available_room?(1, reservation3)).must_equal false
      expect(calendar.available_room?(1, reservation5)).must_equal false
    end
    it "returns false if block is reserved for any given dates" do
      (1..3).each do |i|
        expect(calendar.available_room?(i, block5)).must_equal false
      end
      (1..3).each do |i|
        expect(calendar.available_room?(i, block6)).must_equal false
      end
    end
  end

  describe "#available_rooms" do
    before do
      calendar.add_reservation(reservation1)
    end
    it "returns array of available rooms" do
      available_rooms = calendar.available_rooms(reservation1)
      expect(available_rooms).must_be_kind_of Array
      expect(available_rooms.length).must_equal 19
      expect(available_rooms.first).must_equal 2
    end
    it "returns accurate list when blocks are on calendar" do
      calendar.add_block(block2)
      calendar.add_block(block3)
      available_rooms = calendar.available_rooms(block5)
      expect(available_rooms).must_be_kind_of Array
      expect(available_rooms.length).must_equal 17
      expect(available_rooms.first).must_equal 4
    end
  end
end
