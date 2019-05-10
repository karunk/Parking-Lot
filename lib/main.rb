require "parking_lot"

class Main
  def initialize(output, input_file=nil)
    @output = output
    @input_file = input_file
  end

  def run
    if input_file.nil?
      process_cli
    else
      process_input_file
    end
  end

  private

  attr_reader :output, :input_file

  def parking_lot
    @parking_lot ||= ParkingLot.new
  end

  def process_input_file
    output.puts(parking_lot.greeting)
  end

  def process_cli
    output.puts(parking_lot.greeting)
  end

end