module Command
  class Parser

    def initialize(command_name)
      raise Command::InvalidInputError unless VALID_PARKING_LOT_COMMANDS.include?(command_name)
      @command_name = command_name
    end

    def validate_and_parse!(args)
      validate_command_args!(args)
      process_command_args(args)
      return args
    end

    private 

    def validate_command_args!(args)
      case @command_name
      when SETUP_LOT
        raise Command::InvalidInputError unless setup_lot_args_valid?(args)
      when PARK
        raise Command::InvalidInputError unless park_args_valid?(args)
      when UNPARK
        raise Command::InvalidInputError unless unpark_args_valid?(args)
      when GET_COLOUR_REG_NOS
        raise Command::InvalidInputError unless reg_nos_for_color_args_valid?(args)
      when GET_COLOUR_SLOT_NOS
        raise Command::InvalidInputError unless get_colot_slot_nos_args_valid?(args)
      when GET_SLOT_NO
        raise Command::InvalidInputError unless get_slot_no_args_valid?(args)
      end
    end

    def process_command_args(args)
      case @command_name
      when SETUP_LOT
        process_create_parking_lot_args(args)
      when PARK
        process_park_args(args)
      when UNPARK
        process_leave_args(args)
      end
    end

    def setup_lot_args_valid?(args)
      args.length.eql? 1 and args[0].to_i.to_s.eql? args[0]
    end

    def unpark_args_valid?(args)
      args.length.eql? 1
    end

    def park_args_valid?(args)
      args.length.eql? 2
    end

    def get_slot_no_args_valid?(args)
      args.length.eql? 1
    end

    def get_colot_slot_nos_args_valid?(args)
      args.length.eql? 1
    end

    def reg_nos_for_color_args_valid?(args)
      args.length.eql? 1
    end

    def process_create_parking_lot_args(args)
      args[0] = args[0].to_i
    end

    def process_leave_args(args)
      args[0] = args[0].to_i
    end

    def process_park_args(args)
      args[0] = Car.new(args[0], args[1])
    end
    
  end
end