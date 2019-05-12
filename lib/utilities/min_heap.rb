module Utilities
  
  class MinHeap

    def initialize
      @elements = [nil] 
      @element_position_map = Hash.new
    end

    def <<(element)
      @elements << element
      @element_position_map[element] = @elements.size - 1
      sift_up(@elements.size - 1)
    end

    def count
      return @elements.size - 1
    end

    def elements
      return @elements.drop(1)
    end

    def peek_min
      return @elements[1]
    end

    def extract_min
      exchange(1, @elements.size - 1)
      min_element = @elements.pop
      sift_down(1)
      return min_element
    end

    def delete_element(element)
      element_position = @element_position_map[element]
      unless element_position.nil?
        exchange(element_position, @elements.size - 1)
        element_to_remove = @elements.pop
        @element_position_map.delete(element_to_remove)
        sift_down(element_position)
        return element_to_remove
      end
    end

    private 

    def sift_up(index)
      parent_index = (index / 2)
      return if index <= 1
      return if @elements[index] >= @elements[parent_index]
      exchange(index, parent_index)
      sift_up(parent_index)
    end

    def sift_down(index)
      child_index = (index * 2)
      return if child_index > @elements.size - 1
      not_the_last_element = child_index < @elements.size - 1
      left_child = @elements[child_index]
      right_child = @elements[child_index + 1]
      if not_the_last_element && right_child < left_child
        child_index += 1
      end
      return if @elements[index] <= @elements[child_index]
      exchange(index, child_index)
      sift_down(child_index)
    end

    def exchange(source_index, target_index)
      tmp_source = @elements[source_index]
      tmp_target = @elements[target_index]
      source_element_position = @element_position_map[tmp_source]
      target_element_position = @element_position_map[tmp_target]
      @elements[source_index] = tmp_target
      @elements[target_index] = tmp_source
      @element_position_map[tmp_source] = target_element_position
      @element_position_map[tmp_target] = source_element_position
    end

  end

end