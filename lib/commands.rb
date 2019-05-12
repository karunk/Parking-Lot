module Commands

  PARK = 'park'
  UNPARK = 'leave'
  SETUP_LOT = 'create_parking_lot'
  STATUS = 'status'
  GET_COLOUR_REG_NOS = 'registration_numbers_for_cars_with_colour'
  GET_COLOUR_SLOT_NOS = 'slot_numbers_for_cars_with_colour'
  GET_SLOT_NO = 'slot_number_for_registration_number'

  VALID_PARKING_LOT_COMMANDS = [
    PARK,
    SETUP_LOT,
    UNPARK,
    STATUS,
    GET_COLOUR_REG_NOS,
    GET_COLOUR_SLOT_NOS,
    GET_SLOT_NO
  ]

end