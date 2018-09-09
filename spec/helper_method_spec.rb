require_relative 'spec_helper'
require 'pry'

describe 'self.generate_nights method' do

  before do
    @input = { name: "Vlad the Impaler",
      room_number:  9,
      check_in_date: Date.new(2020,9,9),
      check_out_date: Date.new(2020,9,13),
    }
    @input2 = { name: "Dr. Frankensteen",
      room_number:  9,
      check_in_date: Date.new(2020,9,13),
      check_out_date: Date.new(2020,9,9),
    }
    @reservation = Hotel::Reservation.new(@input)
  end

  it 'generates an array of all nights in a reservation without including the checkout date' do
    @nights = [Date.new(2020,9,9), Date.new(2020,9,10), Date.new(2020,9,11), Date.new(2020,9,12)]

    expect(@reservation.nights_of_stay).must_be_kind_of Array

    @nights.each do |night|
      expect(@reservation.nights_of_stay.include?(night)).must_equal true
    end
  end
end

describe 'self.check_valid_date_range' do

  before do
    @input = { name: "Vlad the Impaler",
      room_number:  9,
      check_in_date: Date.new(2020,9,9),
      check_out_date: Date.new(2020,9,13),
    }
    @input2 = { name: "Dr. Frank N. Furter",
      room_number:  9,
      check_in_date: Date.new(2020,9,13),
      check_out_date: Date.new(2020,9,9),
    }
    @reservation = Hotel::Reservation.new(@input)
  end

  it 'raises an Error if the the check out date is before the check in date date' do
    expect { Hotel::Reservation.new(@input2) }.must_raise StandardError
  end
end

describe 'self.binary_search_list_of_reservations_for_vacancy method' do

  before do
      #TEST RANGE
    @date1 = Date.new(2020,9,9)
    @date2 = Date.new(2020,9,13)
      #INSIDE TEST RANGE
    @date3 = Date.new(2020,9,10)
    @date4 = Date.new(2020,9,12)
      #OUTSIDE TEST RANGE
    @date5 = Date.new(2020,9,4)
    @date6 = Date.new(2020,9,16)

    @input = { name: "Mx Thing",
      room_number: 1,
      check_in_date: @date1,
      check_out_date: @date2,
    }
    @reservation = Hotel::Reservation.new(@input)
    @array_of_reservations = [@reservation]
  end

  it 'given a range of dates, it returns true, if the reservation shares the same dates as a reserved room' do
    @array_of_possible_dates = Hotel::Helper_Method.generate_nights(@date1, @date2)
    expect(Hotel::Helper_Method.binary_search_list_of_reservations_for_vacancy(@array_of_reservations, @array_of_possible_dates)).must_equal true
  end

  it 'it returns true if check in date is in the middle dates of a reserved room'do
    @array_of_possible_dates = Hotel::Helper_Method.generate_nights(@date3, @date4)
    expect(Hotel::Helper_Method.binary_search_list_of_reservations_for_vacancy(@array_of_reservations, @array_of_possible_dates)).must_equal true
  end

  it 'it returns true if the reservation check in date is in the middle dates of a reserved room'do
    @array_of_possible_dates = Hotel::Helper_Method.generate_nights(@date3, @date6)
    expect(Hotel::Helper_Method.binary_search_list_of_reservations_for_vacancy(@array_of_reservations, @array_of_possible_dates)).must_equal true
  end

  it 'it returns true if the check out date is in the middle dates of a reserved room' do
    @array_of_possible_dates = Hotel::Helper_Method.generate_nights(@date5, @date6)
    expect(Hotel::Helper_Method.binary_search_list_of_reservations_for_vacancy(@array_of_reservations, @array_of_possible_dates)).must_equal true
  end

  it 'it returns true if the reservation check in date and check out date is in the middle dates of a reserved room'do
      @array_of_possible_dates = Hotel::Helper_Method.generate_nights(@date3, @date4)
      expect(Hotel::Helper_Method.binary_search_list_of_reservations_for_vacancy(@array_of_reservations, @array_of_possible_dates)).must_equal true
  end

  it 'it returns true if the reservation check in date is in the middle dates of a reserved room'do
    @array_of_possible_dates = Hotel::Helper_Method.generate_nights(@date3, @date6)
    expect(Hotel::Helper_Method.binary_search_list_of_reservations_for_vacancy(@array_of_reservations, @array_of_possible_dates)).must_equal true
  end

  it 'it returns true if the dates of a reserved room fall within a proposed check in date or check out date'do
    @array_of_possible_dates = Hotel::Helper_Method.generate_nights(@date5, @date6)
    expect(Hotel::Helper_Method.binary_search_list_of_reservations_for_vacancy(@array_of_reservations, @array_of_possible_dates)).must_equal true
  end

  it 'it returns false if the reservation check in date is on the check out day of another reservation'do
    @array_of_possible_dates = Hotel::Helper_Method.generate_nights(@date2, @date6)
    expect(Hotel::Helper_Method.binary_search_list_of_reservations_for_vacancy(@array_of_reservations, @array_of_possible_dates)).must_equal false
  end

  it 'it returns false if the reservation check out date is on the check in day of another reservation'do
    @array_of_possible_dates = Hotel::Helper_Method.generate_nights(@date5, @date1)
    expect(Hotel::Helper_Method.binary_search_list_of_reservations_for_vacancy(@array_of_reservations, @array_of_possible_dates)).must_equal false
  end

  describe 'self.sort_reservations_by_date' do
    it 'given an array of dates, it will sort in ascending order' do
        @input = { name: "Mx Thing",
          room_number: 1,
          check_in_date: Date.new(2020,9,9),
          check_out_date: Date.new(2020,9,13),
        }
        @reservation1 = Hotel::Reservation.new(@input)
        @input2 = { name: "Teen Wolf",
          room_number: 1,
          check_in_date: Date.new(2016,7,9),
          check_out_date: Date.new(2016,7,13),
        }
        @reservation2 = Hotel::Reservation.new(@input2)
        @input3 = { name: "Señor Dracula",
          room_number: 1,
          check_in_date: Date.new(2018,7,9),
          check_out_date: Date.new(2018,7,13),
        }
        @reservation3 = Hotel::Reservation.new(@input3)
        @reservations = [@reservation1,@reservation2,@reservation3]
        Hotel::Helper_Method.sort_reservations_by_date(@reservations)

        expect(@reservations.first.name).must_equal "Teen Wolf"
        expect(@reservations.last.name).must_equal "Mx Thing"
    end
  end

  describe 'self.find_room_number method' do
    before do
      @hotel = Hotel::Booking_Manager.new
    end

    it 'returns an instance of Room' do
      expect(Hotel::Helper_Method.find_room_number(@hotel.rooms, 1)).must_be_kind_of Hotel::Room
      expect(Hotel::Helper_Method.find_room_number(@hotel.rooms, 20)).must_be_kind_of Hotel::Room
    end
  end

  describe 'connect_reservation_to_room_and_sort' do

    before do
      @hotel = Hotel::Booking_Manager.new
      @rooms = @hotel.rooms
      @input = { name: "Nosferatu",
        room_number: 1,
        check_in_date: Date.new(2020,9,9),
        check_out_date: Date.new(2020,9,13),
      }
      @input2 = { name: "Mx Thing",
        room_number: 1,
        check_in_date: Date.new(2020,9,9),
        check_out_date: Date.new(2020,9,13),
      }
      @input3 = { name: "Dr. Frank N. Stein",
        room_number: 1,
        check_in_date: Date.new(2018,9,9),
        check_out_date: Date.new(2018,9,13),
      }
    end
    it "given a list of rooms and a room number it adds a reservation to the room's list of reservations" do
      @reservation = Hotel::Reservation.new(@input2)
      @reservation2 = Hotel::Reservation.new(@input3)

      Hotel::Helper_Method.connect_reservation_to_room_and_sort(@rooms, 1, @reservation)
      expect(@rooms.first.reservations.first.name).must_equal "Mx Thing"
      expect(@rooms.first.reservations.first.room_number).must_equal 1

      Hotel::Helper_Method.connect_reservation_to_room_and_sort(@rooms, 1, @reservation2)
      expect(@rooms.first.reservations.first.name).must_equal "Dr. Frank N. Stein"
      expect(@rooms.first.reservations.first.room_number).must_equal 1
      end

      it 'raises an error if a reservation is placed on the same day in a room as an existing reservation' do
        @reservation = Hotel::Reservation.new(@input)
        @reservation2 = Hotel::Reservation.new(@input2)
        Hotel::Helper_Method.connect_reservation_to_room_and_sort(@rooms, 1, @reservation)
        expect{ Hotel::Helper_Method.connect_reservation_to_room_and_sort(@rooms, 1, @reservation2) }.must_raise ArgumentError
      end
    end

    describe 'binary_search_reservations_return_index_if_found method' do
      before do
        @date1 = Date.new(2020,1,9)
        @date2 = Date.new(2020,1,13)
        @date3 = Date.new(2020,2,10)
        @date4 = Date.new(2020,2,12)
        @date5 = Date.new(2020,3,4)
        @date6 = Date.new(2020,3,16)

        #TEST DATES
        @date7 = Date.new(2020,1,11)
        @date8 = Date.new(2020,1,12)
        @date9 =  Date.new(2020,3,16)
        @date10 =  Date.new(2020,4,4)
        @date11 =  Date.new(2020,3,4)

        @input = { name: "Mx Thing",
          room_number: 1,
          check_in_date: @date1,
          check_out_date: @date2,
        }
        @input2 = { name: "Mx Thing",
          room_number: 1,
          check_in_date: @date3,
          check_out_date: @date4,
        }
        @input3 = { name: "Mx Thing",
          room_number: 1,
          check_in_date: @date5,
          check_out_date: @date6,
        }
        @reservation = Hotel::Reservation.new(@input)
        @reservation2 = Hotel::Reservation.new(@input2)
        @reservation3 = Hotel::Reservation.new(@input3)
        @array_of_reservations = [@reservation,@reservation2,@reservation3]
      end
      it 'returns the index of the Reservation in a list of reservations' do
        expect(Hotel::Helper_Method.binary_search_reservations_return_index_if_found(@array_of_reservations, @date7)).must_equal 0
        expect(Hotel::Helper_Method.binary_search_reservations_return_index_if_found(@array_of_reservations, @date8)).must_equal 0
        expect(Hotel::Helper_Method.binary_search_reservations_return_index_if_found(@array_of_reservations, @date9)).must_be_kind_of NilClass
        expect(Hotel::Helper_Method.binary_search_reservations_return_index_if_found(@array_of_reservations, @date10)).must_be_kind_of NilClass
        expect(Hotel::Helper_Method.binary_search_reservations_return_index_if_found(@array_of_reservations, @date11)).must_equal 2
      end
    end

end
