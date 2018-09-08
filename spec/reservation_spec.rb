require_relative 'spec_helper'

describe 'Reservation class' do
  let (:valid_res) {
    date1 = "Jan 11th 2019"
    date2 = "Jan 15th 2019"
    Reservation.new(date1, date2)
  }

  let (:invalid_res1) {
    date1 = "Jan 15th 2019"
    date2 = "Jan 11th 2019"
    Reservation.new(date1, date2)
  }

  let (:invalid_res2) {
    date1 = "Jan 15th 2019"
    date2 = "Jan 15th 2019"
    Reservation.new(date1, date2)
  }

  describe 'Initializer' do
    it 'is an instance of Reservation' do
      expect(valid_res).must_be_kind_of Reservation
      expect(valid_res.room_cost).must_equal 200
      expect(valid_res.dates_booked).must_be_kind_of Array
      expect(valid_res.dates_booked[0]).must_be_kind_of Date
    end

    it 'raises ArgumentError if check_in is later than check_out' do
      expect{ invalid_res1 }.must_raise ArgumentError
    end

    it 'raises ArgumentError if check_in and check_out are the same day' do
      expect{ invalid_res2 }.must_raise ArgumentError
    end
  end

  describe 'date_range' do
    it 'returns an array of dates excluding check_out date' do
      expect(valid_res.dates_booked.first).must_equal Date.parse("Jan 11th 2019")
      expect(valid_res.dates_booked.last).must_equal Date.parse("Jan 14th 2019")
    end
  end

  describe 'length_of_stay' do
    it 'calculates the length_of_stay' do
      expect(valid_res.length_of_stay).must_equal (Date.parse("Jan 15 2019") - Date.parse("Jan 11 2019"))
    end
  end

  describe 'total_cost' do
    it 'calculates the total_cost of a reservation' do
      expect(valid_res.total_cost).must_equal 4 * 200
    end
  end
end

# describe 'BlockOfRooms class' do
#
#   before do
#     start_date = "Oct 1 2018"
#     end_date = "Oct 4 2018"
#     discounted_rate = 180
#     @my_block = BlockOfRooms.new(start_date, end_date, room_cost: discounted_rate)
#   end
#   describe 'Initializer' do
#     it 'is an instance of BlockOfRooms' do
#       expect(@my_block).must_be_kind_of BlockOfRooms
#     end
#   end
#
#   describe 'add_room' do
#     it 'adds a collection of room instances' do
#       room1 = Room.new(room_num: 1)
#       room2 = Room.new(room_num: 2)
#
#       @my_block.add_room(room1)
#       @my_block.add_room(room2)
#
#       expect(@my_block.collection_rooms.count).must_equal 2
#       expect(@my_block.collection_rooms[0]).must_be_kind_of Room
#     end
#   end
# end
