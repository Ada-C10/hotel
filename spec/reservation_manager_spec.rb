require_relative 'spec_helper'
require 'pry'

describe 'ReservationManager' do
  let(:manager){ Hotel::ReservationManager.new }

  describe 'initialize' do

    it 'is set up for specific instance variables and data types' do

      expect(manager.reservations).must_be_kind_of Array
      expect(manager.rooms).must_be_kind_of Array
      expect(manager.room_cost).must_be_kind_of Numeric
      expect(manager.room_block_discount).must_be_kind_of Numeric
    end

    it 'will populate 20 instances of room upon initialization' do

      expect(manager.rooms[0]).must_be_instance_of Hotel::Room
      expect(manager.rooms[19]).must_be_instance_of Hotel::Room
      expect(manager.rooms[20]).must_be_nil
    end

    it 'will throw an error if you try to generate more than  20 rooms' do
      expect{
        rooms = []
        21.times do
          room = Hotel::Room.new
          rooms << room
        end
      }.must_raise StandardError
    end
  end

  let(:find_first_room) {
    date_range = (Date.parse("10/10/2018")..Date.parse("14/10/2018")).to_a
    manager.find_available_room(date_range)
  }

  let(:find_two_rooms) {
    date_range = (Date.parse("10/09/2018")..Date.parse("14/09/2018")).to_a
    rooms = []
    2.times do
      room = manager.find_available_room(date_range)
      rooms << room
    end
    rooms
  }

  let(:fully_booked_manager) {
    fully_booked_manager = Hotel::ReservationManager.new()
    20.times { fully_booked_manager.make_reservation("10/05/2018", "14/05/2018") }
    fully_booked_manager
  }

  describe 'find_available_room' do
    it 'will return the first available room for reservation that date range' do
      expect(find_first_room).must_be_instance_of Hotel::Room
      expect(find_first_room.room_number).must_equal 1
    end

    it 'will return the first available room for 2 reservations in same date range' do
      expect(find_two_rooms.length).must_equal 2
      expect(find_two_rooms[0]).must_be_instance_of Hotel::Room
      expect(find_two_rooms[1]).must_be_instance_of Hotel::Room
      expect(find_two_rooms[0].room_number).must_equal 1
      expect(find_two_rooms[1].room_number).must_equal 1
    end

    it 'will return a message to user if no room available for that date' do
      date_range = (Date.parse("10/05/2018")..Date.parse("14/05/2018")).to_a
      expect(fully_booked_manager.find_available_room(date_range)).must_be_kind_of String
      expect(fully_booked_manager.find_available_room(date_range)).must_equal "Hotel fully booked for this date range. Try a different date."
    end

  end

  let(:valid_total_cost) {
    #4nights
    manager = Hotel::ReservationManager.new
    manager.calculate_total_cost("12/09/2018", "16/09/2018", 200)
  }

  describe 'calculate_total_cost' do

    it 'will calculate total cost given valid room_cost and checkin/checkout' do
      expect(valid_total_cost).must_equal 4 * 200
    end

    it 'will throw error if total cost is 0 or less' do
      expect{
        manager = Hotel::ReservationManager.new
        manager.calculate_total_cost("12/09/2018", "16/09/2018", 0)
      }.must_raise ArgumentError
    end

    it 'will throw error if total cost is negative' do
      expect{
        manager = Hotel::ReservationManager.new
        manager.calculate_total_cost("12/09/2018", "16/09/2018", -200)
      }.must_raise ArgumentError
    end
  end

  let(:valid_add_to_list) {
    input = { checkin_date: "12/09/2018", checkout_date: "15/09/2018", room_number: 2, total_cost: 600, confirmation_id: "ABC12345" }
    reservation = Hotel::Reservation.new(input)
    manager = Hotel::ReservationManager.new
    manager.add_reservation_to_list(reservation)
    manager.reservations[0]
  }

  let(:no_reservations) {
    manager = Hotel::ReservationManager.new
    manager.reservations
  }

  let(:one_reservation) {
    input = { checkin_date: "12/09/2018", checkout_date: "15/09/2018", room_number: 2, total_cost: 600, confirmation_id: "ABC12345" }
    reservation = Hotel::Reservation.new(input)
    manager = Hotel::ReservationManager.new
    manager.add_reservation_to_list(reservation)
    manager.reservations
  }

  describe 'add_reservation_to_list' do

    it 'will add a reservation to the list of reservations' do
      expect(valid_add_to_list).must_be_instance_of Hotel::Reservation
    end

    it 'will increase the count of reservations by 1' do

      expect(no_reservations.length).must_equal 0
      expect(one_reservation.length).must_equal 1
    end

    it 'will throw an argument error if param is not a valid reservation' do
      expect{
        manager = Hotel::ReservationManager.new
        manager.add_reservation_to_list("reservation, 12/24/2018, 12/24/2018")
      }.must_raise ArgumentError
    end
  end

  describe 'parse_reservation_data' do

    let(:parse_one_reservation) {
      manager = Hotel::ReservationManager.new
      #3nights
      checkin_date = "12/09/2018"
      checkout_date = "15/09/2018"
      date_range = (Date.parse(checkin_date)..Date.parse(checkout_date)).to_a
      room_object = manager.find_available_room(date_range)
      room_number = room_object.room_number
      manager.parse_reservation_data(checkin_date, checkout_date, room_number)
    }

    it 'will parse data into form usable by reservation class' do

      expect(parse_one_reservation[:checkin_date]).must_equal "12/09/2018"
      expect(parse_one_reservation[:checkout_date]).must_equal "15/09/2018"
      expect(parse_one_reservation[:room_number]).must_equal 1
      expect(parse_one_reservation[:confirmation_id]).must_match(/^[A-Z]{3}+[\d]{5}/)
      expect(parse_one_reservation[:total_cost]).must_equal 200 * 3
    end
  end

  let(:make_one_reservation) {
    manager = Hotel::ReservationManager.new
    checkin_date = "12/09/2018"
    checkout_date = "15/09/2018"
    manager.make_reservation(checkin_date, checkout_date)
  }

  let(:no_reservations_manager){ Hotel::ReservationManager.new }

  let(:make_one_reservation_manager) {
    manager = Hotel::ReservationManager.new
    checkin_date = "12/09/2018"
    checkout_date = "15/09/2018"
    manager.make_reservation(checkin_date, checkout_date)
    manager
  }

  let(:make_two_reservations_manager) {
    manager = Hotel::ReservationManager.new
    checkin_date1 = "10/09/2018"
    checkout_date1 = "12/09/2018"
    manager.make_reservation(checkin_date1, checkout_date1)
    checkin_date2 = "12/09/2018"
    checkout_date2 = "15/09/2018"
    manager.make_reservation(checkin_date2, checkout_date2)
    manager
  }

  let(:make_three_allowed_overlapping_manager) {
    manager.make_reservation("12/07/2018", "14/07/2018")
    manager.make_reservation("14/07/2018", "16/07/2018")
    manager.make_reservation("16/07/2018", "18/07/2018")
    manager
  }
  let(:make_two_not_allowed_overlapping_manager) {
    manager.make_reservation("12/07/2018", "15/07/2018")
    manager.make_reservation("14/07/2018", "16/07/2018")
    manager
  }

  describe 'make_reservation' do

    it 'will create a new instance of reservation object' do
      expect(make_one_reservation).must_be_instance_of Hotel::Reservation
    end

    #increase count by one
    it 'will increase number of reservations in ReservationManager by 1 each time called' do
      expect(no_reservations_manager.reservations.length).must_equal 0
      expect(make_one_reservation_manager.reservations.length).must_equal 1
      expect(make_two_reservations_manager.reservations.length).must_equal 2
    end


    it 'will store the reservation in the first room for 2 reservations even if they have an overlapping start and end date' do
      expect(make_three_allowed_overlapping_manager.rooms[0].reservations.length).must_equal 3
      expect(make_three_allowed_overlapping_manager.rooms[1].reservations.length).must_equal 0
    end

    it 'will store the reservation in the first and second room if 2 reservations overlap in a bad way' do
      expect(make_two_not_allowed_overlapping_manager.rooms[0].reservations.length).must_equal 1
      expect(make_two_not_allowed_overlapping_manager.rooms[1].reservations.length).must_equal 1
    end

    # #Lazy Test of RoomBlock Methods and Class
    # #<Hotel::RoomBlock:0x00007ffb71ad0ec0
    # @checkin_date=#<Date: 2018-01-01 ((2458120j,0s,0n),+0s,2299161j)>,
    # @checkout_date=#<Date: 2018-01-03 ((2458122j,0s,0n),+0s,2299161j)>,
    # @confirmation_id="BLOCK39065",
    # @num_rooms=3,
    # @reservations=
    # [#<Hotel::Reservation:0x00007ffb721d0f40
    #   @checkin_date=#<Date: 2018-01-01 ((2458120j,0s,0n),+0s,2299161j)>,
    #   @checkout_date=#<Date: 2018-01-03 ((2458122j,0s,0n),+0s,2299161j)>,
    #   @confirmation_id="ZPY64192",
    #   @room_number=1,
    #   @total_cost=320>,
    #   #<Hotel::Reservation:0x00007ffb71ad38c8
    #   @checkin_date=#<Date: 2018-01-01 ((2458120j,0s,0n),+0s,2299161j)>,
    #   @checkout_date=#<Date: 2018-01-03 ((2458122j,0s,0n),+0s,2299161j)>,
    #   @confirmation_id="EOV80156",
    #   @room_number=2,
    #   @total_cost=320>,
    #   #<Hotel::Reservation:0x00007ffb71ad1aa0
    #   @checkin_date=#<Date: 2018-01-01 ((2458120j,0s,0n),+0s,2299161j)>,
    #   @checkout_date=#<Date: 2018-01-03 ((2458122j,0s,0n),+0s,2299161j)>,
    #   @confirmation_id="NHX45362",
    #   @room_number=3,
    #   @total_cost=320>],
    #   @room_number=[1, 2, 3],
    #   @total_cost=960>

    let(:room_block) {
      manager = Hotel::ReservationManager.new()
      manager.make_reservation("01/01/2018", "03/01/2018", 3)
    }

    it 'will make a room block if the number of rooms passed in is between 2 and 5' do

      expect( room_block).must_be_instance_of Hotel::RoomBlock
    end

    it 'will raise an exception if number of rooms is greater than 5' do
      expect{
        manager = Hotel::ReservationManager.new()
        manager.make_reservation("01/01/2018", "03/01/2018", 7)
      }.must_raise ArgumentError
    end

    it 'will raise an exception if number of rooms is 0 or less' do
      expect{
        manager = Hotel::ReservationManager.new()
        manager.make_reservation("01/01/2018", "03/01/2018", 7)
      }.must_raise ArgumentError
    end
  end

  let(:get_reservation_cost) {
    manager = Hotel::ReservationManager.new
    manager.make_reservation("10/05/2018", "12/05/2018")
    manager.get_total_reservation_cost(manager.reservations[0].confirmation_id)
  }

  describe 'get_reservation_total_cost' do

    it 'will retrieve the total_cost of the reservation' do
      expect(get_reservation_cost).must_equal 2 * 200
    end
  end

  describe 'list_all_rooms_in_hotel' do
     it 'will list all rooms' do
       expect(manager.list_all_rooms_in_hotel).must_be_instance_of Array
       expect(manager.list_all_rooms_in_hotel.length).must_equal 20
       expect(manager.list_all_rooms_in_hotel[0]).must_equal 1
     end
  end

  let(:one_less_reservation) {
    manager = Hotel::ReservationManager.new
    manager.make_reservation("10/09/2018", "12/09/2018")
    manager
  }

  describe 'find_all_available_rooms' do

    it 'will return all rooms ids if no rooms booked for that date range' do

      date_range = (Date.parse("10/09/2018")..Date.parse("14/09/2018")).to_a
      rooms_available = manager.find_all_available_rooms(date_range)
      expect(rooms_available).must_be_kind_of Array
      expect(rooms_available.length).must_equal 20
      expect(rooms_available[0]).must_be_kind_of Numeric
    end

    it 'will return one less room id if a room is booked for a date range' do

      date_range = (Date.parse("10/09/2018")..Date.parse("12/09/2018")).to_a
      expect(one_less_reservation.find_all_available_rooms(date_range)).must_be_kind_of Array
      expect((one_less_reservation.find_all_available_rooms(date_range)).length).must_equal 19
      expect((one_less_reservation.find_all_available_rooms(date_range))[0]).must_be_kind_of Numeric
    end

    it 'will return a message to user if no rooms available for that date' do
      date_range = (Date.parse("10/05/2018")..Date.parse("14/05/2018")).to_a
      expect(fully_booked_manager.find_all_available_rooms(date_range)).must_be_kind_of String
      expect(fully_booked_manager.find_all_available_rooms(date_range)).must_equal "Hotel fully booked for this date range. Try a different date."
    end
  end

  describe 'list_rooms_available_today' do
    it 'will lists all rooms available today' do
      expect(manager.list_rooms_available_today).must_be_kind_of Array
      expect((manager.list_rooms_available_today).length).must_equal 20
    end
  end

  describe 'list_available_rooms' do
    it 'will lists all room numbers available for given date range' do
      date_range = (Date.parse("10/01/2018")..Date.parse("14/01/2018")).to_a
      rooms_available = manager.list_available_rooms(date_range)
      expect(rooms_available).must_be_kind_of Array
      expect(rooms_available.length).must_equal 20
      expect(rooms_available[0]).must_be_kind_of Numeric
    end
  end

  let(:no_daily_reservations) {
    manager = Hotel::ReservationManager.new()
    manager.list_daily_reservations("12/09/2018")
  }

  describe 'list_daily_reservations' do

    it 'will return a message to user if no reservations were made for that date' do
      expect(no_daily_reservations).must_be_kind_of String
      expect(no_daily_reservations).must_equal "No reservations for 2018-09-12."
    end

    it 'will raise an array of reservations if found' do
      fully_booked_reservations = fully_booked_manager.list_daily_reservations("10/05/2018")
      expect(fully_booked_reservations).must_be_kind_of Array
      expect(fully_booked_reservations.length).must_equal 20
      expect(fully_booked_reservations[0]).must_match(/^[A-Z]{3}+[\d]{5}/)
    end
  end

end
