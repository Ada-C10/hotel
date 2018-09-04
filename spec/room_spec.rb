require_relative 'spec_helper'
require_relative '../lib/room'

describe 'Room class' do

  describe "#initialize" do
    before do
      @room = Room.new
    end

    it 'is an instance of Room' do
      expect(@room).must_be_kind_of Room
    end
  end




end
