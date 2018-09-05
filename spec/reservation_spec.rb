require_relative 'spec_helper'

describe "Reservation Class" do
  describe "initailize" do
    let (:duration) { Hotel::Duration.new('2018-09-01', '2018-09-05') }
    let (:reservation) { Hotel::Reservation.new(1, duration, 20) }

    it 'stores duration as an object' do
      expect(reservation.duration).must_be_instance_of Hotel::Duration

    end
  end
end
