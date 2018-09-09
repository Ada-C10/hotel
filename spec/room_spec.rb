require_relative 'spec_helper'

describe 'Room class' do
  before do
    room_res = []
    room_res << Reservation.new("Oct 4 2018", "Oct 7 2018")
    room_res << Reservation.new("Oct 7 2018", "Oct 9 2018")

    room_blocked = []
    room_blocked << BlockOfRooms.new("Nov 1 2018", "Nov 5 2018")
    room_blocked << BlockOfRooms.new("Dec 1 2018", "Dec 4 2018")

    @room = Room.new(room_num: 1, reservations: room_res, room_blocks: room_blocked)

  end

  let (:overlap_before) {
    [Date.parse("Oct 3 2018"), Date.parse("Oct 4 2018"), Date.parse("Oct 5 2018")]
  }

  let (:overlap_after) {
    [Date.parse("Oct 8 2018"), Date.parse("Oct 9 2018"), Date.parse("Oct 10 2018")]
  }

  let (:contained_in_range) {
    [Date.parse("Oct 5 2018"), Date.parse("Oct 6 2018"), Date.parse("Oct 7 2018")]
  }

  let (:no_overlap_before) {
    [Date.parse("Sep 4 2018"), Date.parse("Sep 5 2018"), Date.parse("Sep 6 2018")]
  }

  let (:no_overlap_after) {
    [Date.parse("Nov 4 2018"), Date.parse("Nov 5 2018"), Date.parse("Nov 6 2018")]
  }

  let (:end_on_checkin) {
    [Date.parse("Oct 1 2018"), Date.parse("Oct 2 2018"), Date.parse("Oct 3 2018")] # check out Oct 4 2018
  }

  let (:starts_on_checkout) {
    [Date.parse("Oct 9 2018"), Date.parse("Oct 10 2018"), Date.parse("Oct 11 2018")]
  }

  let (:overlap_block) {
    [Date.parse("Dec 2 2018"), Date.parse("Dec 3 2018"), Date.parse("Dec 4 2018")]
  }

  describe 'Initializer' do
    it 'is an instance of Room' do
      expect(@room).must_be_kind_of Room
      expect(@room.room_num).must_equal 1
      expect(@room.reservations).must_be_kind_of Array
      expect(@room.reservations[0]).must_be_kind_of Reservation
    end
  end

  describe 'is_available?' do
    it 'returns true if room is available' do
      expect(@room.is_available?(no_overlap_before)).must_equal true
      expect(@room.is_available?(no_overlap_after)).must_equal true
      expect(@room.is_available?(end_on_checkin)).must_equal true
      expect(@room.is_available?(starts_on_checkout)).must_equal true
    end

    it 'returns false if room is not available' do
      expect(@room.is_available?(overlap_before)).must_equal false
      expect(@room.is_available?(overlap_after)).must_equal false
      expect(@room.is_available?(contained_in_range)).must_equal false
    end
  end

  describe 'is_not_blocked' do
    it 'returns true if room is not blocked' do
      expect(@room.is_not_blocked?(no_overlap_before)).must_equal true
    end

    it 'returns false if room is blocked' do
      expect(@room.is_not_blocked?(overlap_block)).must_equal false
    end
  end

  describe 'add_reservation_to_room' do
    it "adds a reservation instance to room's reservations array" do
      my_res = Reservation.new("Nov 1 2018", "Nov 5 2018")
      room_reservations = @room.add_reservation_to_room(my_res)

      expect(room_reservations).must_be_kind_of Array
      expect(room_reservations.count).must_equal 3
      expect(room_reservations[0]).must_be_kind_of Reservation
    end
  end

  describe 'add_block_to_room' do
    it "adds a block instance to room_blocks array" do
      my_block = BlockOfRooms.new("Nov 1 2018", "Nov 5 2018")
      room_blocked = @room.add_block_to_room(my_block)

      expect(room_blocked).must_be_kind_of Array
      expect(room_blocked.count).must_equal 3
      expect(room_blocked[0]).must_be_kind_of BlockOfRooms
    end
  end
end
