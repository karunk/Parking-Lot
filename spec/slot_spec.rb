require 'slot'
require 'byebug'
RSpec.describe Slot do

  describe 'slot number testing' do
    
    it 'each slot is issued a slot number' do
      slot = Slot.new
      expect(slot.slot_number).to be
    end

  end

end