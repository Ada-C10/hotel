require_relative 'spec_helper'
describe 'reservation class' do

  describe 'reservation instantiation' do

    before do
      @nights = [Date.new(2020,9,9), Date.new(2020,9,10), Date.new(2020,9,11), Date.new(2020,9,12)]
      input = { name: "Vlad the Impaler",
        room_number:  9,
        check_in_date: Date.new(2020,9,9),
        check_out_date: Date.new(2020,9,13),
      }
      @reservation = Reservation.new(input)
    end
    #
    it 'creates an instance of a Reservation' do
      expect(@reservation).must_be_kind_of Reservation
    end

    it 'has a customer name' do
      expect(@reservation.name).must_equal "Vlad the Impaler"
    end

    it 'has has a room number ' do
      expect(@reservation.room_number).must_equal 9
    end
    #
    it 'has a check-in date' do
      expect(@reservation.check_in_date).must_be_kind_of Date
    end

    it 'has a check-out date' do
      expect(@reservation.check_out_date).must_be_kind_of Date
    end

    it 'has an array of all nights that will be charged' do
      expect(@reservation.nights_of_stay).must_be_kind_of Array

      @reservation.nights_of_stay.each do |night|
        expect(night).must_be_kind_of Date

      end
      @nights.each do |night|
        expect(@reservation.nights_of_stay.include?(night)).must_equal true
      end
    end
  end

  describe 'reservation instantiation' do

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
      @reservation = Reservation.new(@input)
    end
    #
    it 'generates an array of all nights in a reservation without including the checkout date' do
      @nights = [Date.new(2020,9,9), Date.new(2020,9,10), Date.new(2020,9,11), Date.new(2020,9,12)]

      expect(@reservation.nights_of_stay).must_be_kind_of Array

      @nights.each do |night|
        expect(@reservation.nights_of_stay.include?(night)).must_equal true
      end
    end

    it 'raises an Error if the the check out date is before the check in date date' do
       expect {Reservation.new(@input2)}.must_raise ArgumentError
    end
  end
end
