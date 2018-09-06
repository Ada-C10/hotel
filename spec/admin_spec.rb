require_relative 'spec_helper'

describe 'Concierge class' do
  describe 'all_rooms method' do
    it 'shows all rooms in hotel' do
      Lodging::Room.new(10)

      Lodging::Concierge.all_rooms
    end
  end
end
