require_relative 'spec_helper'

describe Room do

  describe "Room instantiation" do
    describe "#initialize" do
        it "Takes cost and id" do
          room = Room.new(id = 1, cost = 200)

          expect(room).must_respond_to :id
          expect(room.id).must_equal id

          expect(room).must_respond_to :cost
          expect(room.cost).must_equal cost

        end
      end
    end
  end
