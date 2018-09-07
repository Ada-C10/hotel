require_relative 'spec_helper'

describe 'Room' do
  before do
    @room = Hotel::Room.new(1)
  end

  describe 'initialize' do

    it 'will initialize on instance of a room' do
      expect(@room).must_be_instance_of Hotel::Room
    end

    it 'is set up for specific attributes and data types' do
      [:reservations, :room_number].each do |prop|
        expect(@room).must_respond_to prop
      end

      expect(@room.reservations).must_be_kind_of Array
      expect(@room.reservations).must_be_empty
      expect(@room.room_number).must_be_kind_of Integer
    end
  end

  let(:one_reservation_added) {
    input = {checkin_date: "13/12/2018", checkout_date: "15/12/2018", room_number: 1}
    @room.add_reservation(Hotel::Reservation.new(input))
    @room.reservations }

    let(:another_reservation_added) {
      input = {checkin_date: "16/12/2018", checkout_date: "18/12/2018", room_number: 2}
      @room.add_reservation(Hotel::Reservation.new(input))
      @room.reservations }

      describe 'add_reservation' do

          it 'will increment the reservations by one' do

            expect(@room.reservations.length).must_equal 0
            expect(one_reservation_added.length).must_equal 1
            expect(another_reservation_added.length).must_equal 2
          end
        end

        let(:false_available) {
          input = {checkin_date: "12/12/2018", checkout_date: "15/12/2018", room_number: 1}
          @room.add_reservation(Hotel::Reservation.new(input))
          range = (Date.parse("13/12/2018")..Date.parse("15/12/2018")).to_a
          @room.is_available?(range)
        }

        let(:true_available) {
          input = {checkin_date: "13/12/2018", checkout_date: "15/12/2018", room_number: 1}
          @room.add_reservation(Hotel::Reservation.new(input))
          range = (Date.parse("19/12/2018")..Date.parse("20/12/2018")).to_a
          @room.is_available?(range)
        }

        let(:false_available_second) {
          input1 = {checkin_date: "09/12/2018", checkout_date: "11/12/2018", room_number: 1}
          @room.add_reservation(Hotel::Reservation.new(input1))
          input2 = {checkin_date: "12/12/2018", checkout_date: "15/12/2018", room_number: 1}
          @room.add_reservation(Hotel::Reservation.new(input2))
          range = (Date.parse("13/12/2018")..Date.parse("15/12/2018")).to_a
          @room.is_available?(range)
        }

        let(:end_start_overlap) {
          input = {checkin_date: "08/10/2018", checkout_date: "10/10/2018", room_number: 1}
          @room.add_reservation(Hotel::Reservation.new(input))
          range = (Date.parse("10/10/2018")..Date.parse("14/10/2018")).to_a
          @room.is_available?(range)
        }

        describe 'is_available?' do

          it 'will return true if given date range not present in first reservation' do
            expect(true_available).must_equal true
          end

          it 'will return false if given date range present in first reservation' do
            expect(false_available).must_equal false
          end

          it 'will return false if given date range present in second reservation' do
            expect(false_available_second).must_equal false
          end

          it 'will return true even if given date range checkin date is same as a reservation end date' do
            expect(end_start_overlap).must_equal true
          end
        end

      end
