require 'byebug'
require 'car'

class CommandParser

  include Commands

  def initialize(command_name)
    @command_name = command_name
  end

  def validate_and_parse!(command_args)
    validate_command_name!
    validate_and_parse_command_args!(command_args)
  end

  def validate_command_name!
    raise StandardError.new("Invalid Command. Please try again.") unless VALID_PARKING_LOT_COMMANDS.include?(@command_name)
  end

  def validate_and_parse_command_args!(command_args)
    case @command_name
    when CREATE_PARKING_LOT
      unless command_args.length == 1 and command_args[0].to_i.to_s == command_args[0] 
        raise StandardError.new("Invalid parameters passed or missing parameters found")
      end
      command_args[0] = command_args[0].to_i
    when PARK
      unless command_args.length == 2
        raise StandardError.new("Invalid parameters passed or missing parameters found")
      end
      command_args[0] = Car.new(command_args[0], command_args[1])

    when LEAVE
      unless command_args.length == 1
        raise StandardError.new("Invalid parameters passed or missing parameters found")
      end
      command_args[0] = command_args[0].to_i

    when STATUS
      unless command_args.length == 0
        raise StandardError.new("Invalid parameters passed or missing parameters found")
      end

    when REGISTRATION_NUMBERS_FOR_CARS_WITH_COLOUR
      unless command_args.length == 1
        raise StandardError.new("Invalid parameters passed or missing parameters found")
      end

    when SLOT_NUMBERS_FOR_CARS_WITH_COLOUR
      unless command_args.length == 1
        raise StandardError.new("Invalid parameters passed or missing parameters found")
      end

    when SLOT_NUMBER_FOR_REGISTRATION_NUMBER
      unless command_args.length == 1
        raise StandardError.new("Invalid parameters passed or missing parameters found")
      end
    end

  end
  
end