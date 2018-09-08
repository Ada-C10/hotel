require_relative "spec_helper"

describe "HotBook::Reservation class" do
  let(:daterange) {HotBook::DateRange.new("apr_6", "apr_8")}
  let(:args) {daterange: daterange}
  let(:reservation) {HotBook::Reservation.new(args)}

  describe "initialize method" do
  end

  describe "cost method" do
  end

end
