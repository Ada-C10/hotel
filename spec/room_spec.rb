require_relative 'spec_helper'

describe 'Room class' do
  let (:date_range) {
    [Date.parse("Oct 4 2018"), Date.parse("Oct 5 2018"), Date.parse("Oct 6 2018")] # check out Oct 7 2018
  }

  let (:overlap_before) {
    [Date.parse("Oct 3 2018"), Date.parse("Oct 4 2018"), Date.parse("Oct 5 2018")]
  }

  let (:overlap_after) {
    [Date.parse("Oct 5 2018"), Date.parse("Oct 6 2018"), Date.parse("Oct 7 2018")]
  }

  let (:contained_in_range) {
    [Date.parse("Oct 5 2018"), Date.parse("Oct 6 2018")]
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
    [Date.parse("Oct 7 2018"), Date.parse("Oct 8 2018"), Date.parse("Oct 9 2018")]
  }

  describe 'Initializer' do
    it 'is an instance of Room' do
      room = Room.new(room_num: 1, dates_booked: date_range)

      expect(room).must_be_kind_of Room
      expect(room.room_num).must_equal 1
      expect(room.cost).must_equal 200
      expect(room.dates_booked).must_equal date_range
      expect(room.blocked_status).must_equal "unblocked"
    end
  end

  describe 'is_available?' do
    it 'returns true if room is available' do
      room = Room.new(room_num: 1, dates_booked: date_range)

      expect(room.is_available?(no_overlap_before)).must_equal true
      expect(room.is_available?(no_overlap_after)).must_equal true
      expect(room.is_available?(end_on_checkin)).must_equal true
      expect(room.is_available?(starts_on_checkout)).must_equal true
    end

    it 'returns false if room is not available' do
      room = Room.new(room_num: 1, dates_booked: date_range)

      expect(room.is_available?(overlap_before)).must_equal false
      expect(room.is_available?(overlap_after)).must_equal false
      expect(room.is_available?(contained_in_range)).must_equal false
    end
  end

  describe 'add_booked_dates' do
    it "adds a range of dates into the room's booked_dates array" do
      room = Room.new(room_num: 1)
      room.add_booked_dates(date_range)

      expect(room.dates_booked).must_be_kind_of Array
      expect(room.dates_booked[0]).must_equal Date.parse("Oct 4 2018")
      expect(room.dates_booked[2]).must_equal Date.parse("Oct 6 2018")
    end
  end

  # describe 'add_reservation' do
  #   it "adds a reservation instance to the room's array of reservations" do
  #     room = Room.new(room_num: 1)
  #     room.add_reservation(Reservation.new("Oct 5 2018", "Oct 8 2018"))
  #
  #     expect(room.reservations).must_be_kind_of Array
  #     expect(room.reservations.count).must_equal 1
  #     expect(room.reservations[0]).must_be_kind_of Reservation
  #   end
  # end
end
