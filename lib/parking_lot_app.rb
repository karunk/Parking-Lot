require 'utilities/min_heap'
require 'exceptions/command/invalid_input_error'
require 'exceptions/max_capacity_error'
require 'exceptions/duplicate_parking_error'
require 'exceptions/not_found_error'
require 'models/car'
require 'command/command'
require 'command/parser'
require 'command/processor'
require 'models/slot'
require 'models/ticket'
require 'models/parking_lot'


class ParkingLotApp
  def initialize(output, input_file=nil)
    @output = output
    @input_file = input_file
  end

  def run
    begin
      input_file.nil? ? process_cli : process_input_file
    rescue StandardError => e
      output.puts("#{e.message}")
    end
  end

  private

  attr_reader :output, :input_file

  def command_processor
    @command_processor ||= Command::Processor.new
  end

  def verify_input_file
    raise ArgumentError.new("Invalid input file #{input_file}") unless File.file?(input_file)
  end

  def process_input_file
    verify_input_file
    File.foreach(input_file) {|input_command| 
      begin
        output.puts(command_processor.process(input_command))
      rescue StandardError => e
        output.puts("#{e.message}")
      end
    }
  end

  def process_cli
    loop do 
      input_command = gets.chomp
      begin
        break if input_command.eql?(Command::EXIT) 
        output.puts(command_processor.process(input_command))
      rescue StandardError => e
        output.puts("#{e.message}")
      end
    end
  end

end