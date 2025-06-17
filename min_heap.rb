require 'byebug'

class MinHeap
  attr_accessor :data

  def initialize
    @data = []
  end

  def insert(value:)
    data << value
    heapify_up(index: data.size - 1)
    value
  end

  def delete
    return if data.size.zero?

    # Move last to first
    last_element = data.pop

    if !data.size.zero?
      data[0] = last_element
      heapify_down(index: 0)
    end

    last_element
  end

  private

  def heapify_down(index:)
    # Delete the head element, take last element, put it first and heapify_down
    left_index = left_child(index:)
    right_index = right_child(index:)

    return if index >= data.size || left_index >= data.size

    left_value = data[left_index]
    right_value = data[right_index]
    our_value = data[index]

    if right_value && left_value > right_value && our_value > right_value
      # Swap
      data[index] = right_value
      data[right_index] = our_value
      heapify_down(index: right_index)
    elsif right_value && right_value > left_value && our_value > left_value
      # Swap
      data[index] = left_value
      data[left_index] = our_value
      heapify_down(index: left_index)
    elsif left_value == right_value && our_value > right_value
      # Swap
      data[index] = right_value
      data[right_index] = our_value
      heapify_down(index: right_index)
    end
  end

  def heapify_up(index:)
    return if index.zero?

    parent_index = parent(index:)
    parent_value = data[parent_index]
    value = data[index]

    return if parent_value <= value

    # swap our value with our parent
    # Swap heapify_up until parent_value <= value
    data[index] = parent_value
    data[parent_index] = value
    heapify_up(index: parent_index)
  end

  def parent(index:)
    (index - 1) / 2
  end

  def left_child(index:)
    index * 2 + 1
  end

  def right_child(index:)
    index * 2 + 2
  end
end
