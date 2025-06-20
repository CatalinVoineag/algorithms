require 'byebug'

class MinHeap
  attr_accessor :data

  def initialize
    @data = []
  end

  def insert(value)
    data << value
    heapify_up(index: data.size - 1)
    value
  end

  def delete
    return if data.size.zero?

    # Move last to first
    first_element = data.first
    last_element = data.pop

    if !data.size.zero?
      data[0] = last_element
      heapify_down(index: 0)
    end

    first_element
  end

  def update(index:, value:)
    data[index] = value
    heapify_up(index:)
  end

  private

  def heapify_down(index:)
    # Delete the head element, take last element, put it first and heapify_down
    left_index = left_child(index:)
    right_index = right_child(index:)

    smallest_index = index

    if left_index < data.size && data[left_index] < data[smallest_index]
      smallest_index = left_index
    end

    if right_index < data.size && data[right_index] < data[smallest_index]
      smallest_index = right_index
    end

    if smallest_index != index
      data[index], data[smallest_index] = data[smallest_index], data[index]
      heapify_down(index: smallest_index)
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
