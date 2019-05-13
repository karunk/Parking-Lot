module Command

  PARK = 'park'
  UNPARK = 'leave'
  SETUP_LOT = 'create_parking_lot'
  STATUS = 'status'
  GET_COLOUR_REG_NOS = 'registration_numbers_for_cars_with_colour'
  GET_COLOUR_SLOT_NOS = 'slot_numbers_for_cars_with_colour'
  GET_SLOT_NO = 'slot_number_for_registration_number'
  EXIT = 'exit'

  VALID_PARKING_LOT_COMMANDS = [
    PARK,
    SETUP_LOT,
    UNPARK,
    STATUS,
    GET_COLOUR_REG_NOS,
    GET_COLOUR_SLOT_NOS,
    GET_SLOT_NO,
    EXIT
  ]

  COMMAND_METHOD_MAPPINGS = {
    PARK => 'park',
    SETUP_LOT => 'setup_parking_lot',
    UNPARK => 'unpark',
    STATUS =>'status',
    GET_COLOUR_REG_NOS => 'get_colour_reg_nos',
    GET_COLOUR_SLOT_NOS =>'get_colour_slot_nos',
    GET_SLOT_NO => 'get_slot_nos' 
  }

end