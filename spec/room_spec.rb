require_relative 'spec_helper'

describe "Room" do
  let(:id) {
    1337
  }
  
  describe "#initialize" do
    it "Creates an instance of room" do
      room = Hotel::Room.new(id)

      expect(room).must_be_kind_of Hotel::Room
    end

    it "Keeps track of ID" do
      room = Hotel::Room.new(id)

      expect(room).must_respond_to :id
      expect(room.id).must_equal id
    end

    it "Keeps track of Availability Status by Date in a hash" do
      room = Hotel::Room.new(id)

      expect(room).must_respond_to :status_by_date
      expect(room.status_by_date).must_be_kind_of Hash
      room.status_by_date.each do |date, status|
        expect(date).must_be_kind_of Date
        expect(status).must_be_kind_of Symbol
      end
    end
  end
end
