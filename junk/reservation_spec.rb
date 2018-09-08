require_relative 'spec_helper'

describe 'Lodging Reservation methods' do
  before(:each) do
    Lodging::Room.class_variable_set(:@@room_list, [])
  end

  let(:concierge){
    Lodging::Concierge.new(15)
  }

  describe 'check status' do
    before do
      Lodging.create_rooms(5)
    end

    describe 'room status' do
      it 'errors if no available rooms' do
        room = [{room_number: 2, status: :unavailable, cost: 200}]

        ap room

        expect(Lodging.room_status(room)).must_raise ArgumentError

      end

    end

    it 'returns one available room if no error' do
      avail = Lodging.room_status(concierge.all_rooms)
      # ap avail

      expect(avail).must_be_instance_of Hash
      expect(avail[:status]).must_equal :available

    end
  end

  # describe 'reservation' do
  #   it 'switches room status to unavailable' do
  #
  #   end
  #
  #   it 'switches status of room instance to unavailable' do
  #
  #   end
  #
  # end

  # describe 'reciept' do
  #   it 'calculates room total based on room cost per night' do
  #
  #   end
  #
  #   it 'does not calculate last date of reservation in total' do
  #
  #   end
  # end

end
