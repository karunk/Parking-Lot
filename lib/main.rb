require 'parking_lot_commands'
require 'parking_lot_command_processor'
require 'parking_lot'
require 'byebug'

class Main
  def initialize(output, input_file=nil)
    @output = output
    @input_file = input_file
  end

  def run
    begin
      input_file.nil? ? process_cli : process_input_file
    rescue StandardError => e
      output.puts("#{e.class}: #{e.message}")
    end
  end

  private

  attr_reader :output, :input_file

  def parking_lot
    @parking_lot ||= ParkingLot.new
  end

  def verify_input_file
    raise ArgumentError.new("Invalid input file #{input_file}") unless File.file?(input_file)
  end

  def process_input_file
    verify_input_file
    File.foreach(input_file) {|input_command| 
      begin
        output.puts(parking_lot.process_command(input_command))
      rescue StandardError => e
        output.puts("#{e.class}: #{e.message}")
      end
    }
  end

  def process_cli
    loop do 
      input_command = gets.chomp
      begin
        break if input_command.eql?("exit") 
        output.puts(parking_lot.process_command(input_command))
      rescue StandardError => e
        output.puts("#{e.class}: #{e.message}")
      end
    end
  end

end