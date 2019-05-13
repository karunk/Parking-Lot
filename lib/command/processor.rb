module Command
  class Processor

    def initialize
      @parking_lot = nil
      @command_name = nil
      @parsed_args = nil
    end

    def process!(raw_command)
      parse_command!(raw_command)
      output = execute_command!
      return output
    end

    def setup_parking_lot
      raise InitializationError if parking_lot_initialized?
      parking_lot_capacity = @parsed_args[0]
      @parking_lot = ParkingLot.new(parking_lot_capacity)
      return "Created a parking lot with #{@parking_lot.total_capacity} slots"
    end

    def park
      raise ParkingLotNotFoundError unless parking_lot_initialized?
      car = @parsed_args[0]
      ticket = @parking_lot.park!(car)
      return "Allocated slot number: #{ticket.parked_slot.slot_number}"
    end

    def unpark
      raise ParkingLotNotFoundError unless parking_lot_initialized?
      ticket_id = @parsed_args[0]
      @parking_lot.unpark!(ticket_id)
      return "Slot number #{ticket_id} is free"
    end

    def status
      raise ParkingLotNotFoundError unless parking_lot_initialized?
      status_data = @parking_lot.status
      return status_table_string(status_data)
    end

    def get_colour_reg_nos
      raise ParkingLotNotFoundError unless parking_lot_initialized?
      colour = @parsed_args[0]
      registration_numbers = @parking_lot.get_registration_numbers_for_colour(colour)
      return registration_numbers.join(', ')
    end

    def get_colour_slot_nos
      raise ParkingLotNotFoundError unless parking_lot_initialized?
      colour = @parsed_args[0]
      slot_numbers = @parking_lot.get_slot_numbers_for_colour(colour)
      return slot_numbers.join(', ')
    end

    def get_slot_nos
      raise ParkingLotNotFoundError unless parking_lot_initialized?
      car_registration_number = @parsed_args[0]
      slot_number = @parking_lot.get_parked_slot_number!(car_registration_number)
      return slot_number.to_s
    end

    private 

    def parse_command!(raw_command)
      @command_name, unparsed_args = get_command_name_and_args(raw_command)
      @parsed_args = Command::Parser.new(@command_name).validate_and_parse!(unparsed_args)
    end

    def execute_command!
      return self.public_send(COMMAND_METHOD_MAPPINGS[@command_name])
    end

    def parking_lot_initialized?
      !@parking_lot.nil? and @parking_lot.class == ParkingLot
    end
    
    def get_command_name_and_args(raw_command)
      raw_command = raw_command.split
      command_name = raw_command[0]
      raw_command.shift
      command_args = raw_command
      return [command_name, command_args]
    end

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
end