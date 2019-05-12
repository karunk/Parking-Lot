require 'utilities/min_heap'

RSpec.describe Utilities::MinHeap, type: :class do

  describe 'initialization tests' do

    it 'initializes with a null element at the first position' do
      min_heap = Utilities::MinHeap.new
      expect(min_heap.count).to eq(0)
    end

    it 'peek min is nil with no elements' do
      min_heap = Utilities::MinHeap.new
      expect(min_heap.peek_min).to eq(nil)
    end

  end

  describe 'min heap ordering on insert' do

    it 'preserves ordering of one element' do
      min_heap = Utilities::MinHeap.new
      min_heap << 1
      expect(min_heap.count).to eq(1)
      expect(min_heap.peek_min).to eq(1)
    end

    it 'preserves ordering of two elements in order' do
      min_heap = Utilities::MinHeap.new
      min_heap << 1
      min_heap << 2
      expect(min_heap.count).to eq(2)
      expect(min_heap.peek_min).to eq(1)
    end

    it 'preserves ordering of two elements reverse' do
      min_heap = Utilities::MinHeap.new
      min_heap << 2
      min_heap << 1
      expect(min_heap.count).to eq(2)
      expect(min_heap.peek_min).to eq(1)
    end

    it 'preserves ordering of three elements out of order' do
      min_heap = Utilities::MinHeap.new
      min_heap << 3
      min_heap << 1
      min_heap << 2
      expect(min_heap.count).to eq(3)
      expect(min_heap.peek_min).to eq(1)
    end

  end

  describe 'extract min testing' do

    it 'insert in asc - preserves ordering after extract min' do
      min_heap = Utilities::MinHeap.new
      for i in 1..10
        min_heap << i
      end
      expect(min_heap.count).to eq(10)
      expect(min_heap.peek_min).to eq(1)

      min_element = min_heap.extract_min
      expect(min_element).to eq(1)
      expect(min_heap.count).to eq(9)
    end

    it 'insert in desc - preserves ordering after extract min' do
      min_heap = Utilities::MinHeap.new
      for i in 1..10
        min_heap << 11-i
      end
      expect(min_heap.count).to eq(10)
      expect(min_heap.peek_min).to eq(1)

      min_element = min_heap.extract_min
      expect(min_element).to eq(1)
      expect(min_heap.count).to eq(9)
    end

    it 'insert random - preserves ordering after extract min' do
      min_heap = Utilities::MinHeap.new

      test_elements = [7,5,8,12,6]

      test_elements.each do |element|
        min_heap << element
      end

      expect(min_heap.count).to eq(5)
      expect(min_heap.peek_min).to eq(5)

      elements_after_insertion = [5,6,8,12,7]

      min_heap.elements.each_with_index do |element, index|
        expect(element).to eq(elements_after_insertion[index])
      end

      min_element = min_heap.extract_min
      expect(min_element).to eq(5)
      expect(min_heap.count).to eq(4)

      elements_after_remove_min = [6,7,8,12]

      min_heap.elements.each_with_index do |element, index|
        expect(element).to eq(elements_after_remove_min[index])
      end
    end

  end

  describe 'delete element testing' do

    it 'deletes an element and preserves ordering' do
      min_heap = Utilities::MinHeap.new

      test_elements = [7,5,8,12,6]

      test_elements.each do |element|
        min_heap << element
      end

      expect(min_heap.count).to eq(5)
      expect(min_heap.peek_min).to eq(5)

      element_to_delete = 12
      deleted_element = min_heap.delete_element(element_to_delete)

      expect(deleted_element).to eq(12)
      expect(min_heap.count).to eq(4)

      elements_after_deletion = [5,6,8,7] # remove '12'

      min_heap.elements.each_with_index do |element, index|
        expect(element).to eq(elements_after_deletion[index])
      end
    end


  end

end