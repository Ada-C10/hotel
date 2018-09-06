require_relative 'spec_helper'
require 'pry'

describe "Reservation Hub class" do

  before do
    @reservation_hub = Hotel::ReservationHub.new

    @reservation1 = Hotel::Reservation.new(2018,01,03,2018,01,07)
    @reservation2 = Hotel::Reservation.new(2018,04,02,2018,04,06)
    @reservation3 = Hotel::Reservation.new(2018,02,04,2018,02,12)

  end


  describe "Reservation Hub initialization" do

    it "is an instance of Reservation Hub" do
      expect(@reservation_hub).must_be_kind_of Hotel::ReservationHub
    end

    it "can access all rooms in the hotel" do
      expect(@reservation_hub.rooms.length).must_equal 20
    end

    it "must initialize with an empty array of reservations" do
      expect(@reservation_hub.reservations).must_be_kind_of Array

      expect(@reservation_hub.reservations.length).must_equal 0
    end
  end

  describe "add reservation" do

    before do
      @reservation_hub = Hotel::ReservationHub.new
    end

    it "adds a new reservation to array of all reservations" do

      @reservation4 = @reservation_hub.add_reservation(2018,06,12,2018,07,01)

      @reservation4 = @reservation_hub.add_reservation(2017,01,02,2017,01,06)

      expect(@reservation_hub.reservations.length).must_equal 2

    end


    describe "find reservation" do

      before do
        @reservation_hub = Hotel::ReservationHub.new

        @reservation1 = Hotel::Reservation.new(2018,01,03,2018,01,07)
        @reservation2 = Hotel::Reservation.new(2018,04,02,2018,04,06)
        @reservation3 = Hotel::Reservation.new(2018,01,03,2018,02,12)
      end

      it "returns a list of reservations based on a start date" do

        expect(@reservation_hub.find_reservations(2018-01-03)).must_be_kind_of Array

        expect(@reservation_hub.find_reservations(2018-01-03).lenght).must_equall 2

        #each must be kind of (instance of?) reservation


      end


    end



  end


end





  #As an administrator, I can access the list of all of the rooms in the hotel
  #As an administrator, I can reserve a room for a given date range
  #As an administrator, I can access the list of reservations for a specific date
  #def - find reservations (find all?) (date)
  #return array of reservations

  #As an administrator, I can get the total cost for a given reservation




  # it "will add the new reservation to the array" do
  #   # binding.pry
  #   # @reservations << @reservation1
  #   expect(@reservations).must_include @reservation1
  # end

  # it 'will return all reservations' do
  #   expect(@reservations.length).must_equal 2
  # end

  # it 'will return an array of all reservations' do
  #   reservations = Hotel::Reservation.all
  #   expect(reservations).must_be_kind_of Array
  # end

  # it "each item in array is a Reservation instance" do
  #   @reservations
  # end


  # it "Returns an array of all customers" do
  #   customers = Customer.all
  #
  #   expect(customers.length).must_equal 35
  #   customers.each do |c|
  #     expect(c).must_be_kind_of Customer
  #   end
  # end



# end
