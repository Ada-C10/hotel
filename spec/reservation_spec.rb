require_relative 'spec_helper'

describe 'Reservation' do
  before do
    input = { checkin_date: "12/09/2018", checkout_date: "15/09/2018", room_number: 2, total_cost: 600, confirmation_id: "ABC12345"}
    #3 nights
    @reservation = Hotel::Reservation.new(input)
  end

  describe 'initialize' do
    it 'will instantiate as reservation object' do
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end

    it 'is set up for specific attributes and data types' do
      [:checkin_date, :checkout_date, :room_number, :confirmation_id, :total_cost].each do |prop|
        expect(@reservation).must_respond_to prop
      end

      expect(@reservation.checkin_date).must_be_kind_of Date
      expect(@reservation.checkout_date).must_be_kind_of Date
      expect(@reservation.room_number).must_be_kind_of Numeric
      expect(@reservation.total_cost).must_be_kind_of Numeric
      expect(@reservation.confirmation_id).must_be_kind_of String
    end
  end

end
