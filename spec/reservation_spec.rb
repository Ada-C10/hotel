require_relative 'spec_helper'

describe 'Lodging Reservation' do
  before(:each) do
    Lodging::Room.class_variable_set(:@@room_list, [])
  end

  describe 'check status' do
    before do
      Lodging.create_rooms(5)
    end

    it 'errors if all rooms are unavailable' do
      rooms = Lodging.room_status(Lodging::Concierge.all_rooms)
      



    end

    it 'returns one available room if no error' do
      avail = Lodging.room_status(Lodging::Concierge.all_rooms)
      ap avail

      expect(avail).must_be_instance_of Hash
      expect(avail[:status]).must_equal :available

    end
  end

  describe 'reservation' do
    it 'switches room status to unavailable' do

    end

    it 'returns date range of reservation' do

    end

    it 'errors if invalid date range' do

    end
  end

  describe 'reciept' do
    it 'calculates room total based on room cost per night' do

    end

    it 'does not calculate last date of reservation in total' do

    end
  end

end
