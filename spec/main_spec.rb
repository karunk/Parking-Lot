require "main"
require "parking_lot"

RSpec.describe Main do
  let(:parking_lot) {ParkingLot.new}

  it "prints example output" do
    output = StringIO.new
    main = Main.new(output)

    main.run

    expect(output.string).to include(parking_lot.greeting)
  end
end