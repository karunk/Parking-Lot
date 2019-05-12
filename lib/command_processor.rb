require 'parking_lot'
require 'commands'
require 'command_parser'

class CommandProcessor

  include Commands

  def initialize
    @parking_lot = nil
  end

  def parking_lot_initialized?
    !@parking_lot.nil? and @parking_lot.class == ParkingLot
  end

  def process(command)
    command = command.split
    command_name = command[0]
    command.shift
    command_args = command
    messg = nil

    case command_name
    when CREATE_PARKING_LOT
      CommandParser.new(CREATE_PARKING_LOT).validate_and_parse!(command_args)
      parking_lot_capacity = command_args[0]
      @parking_lot = ParkingLot.new(parking_lot_capacity)
      messg = "Created a parking lot with #{@parking_lot.total_capacity} slots"
    when PARK
      CommandParser.new(PARK).validate_and_parse!(command_args)
      car = command_args[0]
      ticket = @parking_lot.park!(car)
      messg = "Allocated slot number: #{ticket.parked_slot.slot_number}"

    when LEAVE
      CommandParser.new(LEAVE).validate_and_parse!(command_args)
      ticket_id = command_args[0]
      @parking_lot.unpark!(ticket_id)
      messg = "Slot number #{ticket_id} is free"

    when STATUS
      CommandParser.new(STATUS).validate_and_parse!(command_args)
      status_data = @parking_lot.status
      messg = status_table_string(status_data)

    when REGISTRATION_NUMBERS_FOR_CARS_WITH_COLOUR
      CommandParser.new(REGISTRATION_NUMBERS_FOR_CARS_WITH_COLOUR).validate_and_parse!(command_args)
      colour = command_args[0]
      registration_numbers = @parking_lot.get_registration_numbers_for_colour(colour)
      messg = registration_numbers.join(', ')

    when SLOT_NUMBERS_FOR_CARS_WITH_COLOUR
      CommandParser.new(SLOT_NUMBERS_FOR_CARS_WITH_COLOUR).validate_and_parse!(command_args)
      colour = command_args[0]
      slot_numbers = @parking_lot.get_slot_numbers_for_colour(colour)
      messg = slot_numbers.join(', ')

    when SLOT_NUMBER_FOR_REGISTRATION_NUMBER
      CommandParser.new(SLOT_NUMBER_FOR_REGISTRATION_NUMBER).validate_and_parse!(command_args)
      car_registration_number = command_args[0]
      slot_number = @parking_lot.get_parked_slot_number!(car_registration_number)
      messg = slot_number.to_s
    end

    messg == "Invalid Command. Please try again." if messg.nil?
    return messg
  end

  private 

  def status_table_string(data)
    tmp = "Slot No.    Registration No    Colour\n"
    data.each do |row|
      tmp+=row[0].to_s
      tmp+="           "
      tmp+=row[1].to_s
      tmp+="      "
      tmp+=row[2].to_s
      tmp+="\n"
    end
    return tmp
  end

end