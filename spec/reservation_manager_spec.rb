require_relative 'spec_helper'

describe 'ReservationManager' do
  before do
    @reservation_manager = Hotel::ReservationManager.new
  end

  describe 'initialize' do

    it 'will initialize on instance of a reservation' do
      expect(@reservation_manager).must_be_instance_of Hotel::ReservationManager
    end

  
  end




end
