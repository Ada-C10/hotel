require_relative 'spec_helper'
require_relative '../lib/reservation'

# Wave 1 Tracking Reservations
# 1. access the list of all of the rooms in the hotel
# 2. reserve a room for a given date range
# 3. access the list of reservations for a specific date
# 4. get the total cost for a given reservation
#
# The hotel has 20 rooms, and they are numbered 1 through 20
# Every room is identical, and a room always costs $200/night
# The last day of a reservation is the checkout day, so the guest should not be charged for that night
# For this wave, any room can be reserved at any time, and you don't need to check whether reservations conflict with each other (this will come in wave 2!)

describe 'Reservation class' do

  describe "#initialize" do
    before do
      @reservation = Reservation.new
    end

    it 'is an instance of Reservation' do
      expect(@reservation).must_be_kind_of Reservation
    end


  end




end
