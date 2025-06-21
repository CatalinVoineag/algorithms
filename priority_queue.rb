# frozen_string_literal: true

require 'byebug'

class PriorityQueue
  attr_accessor :data, :hash

  def initialize
    @data = []
    @hash = {}
  end

  def insert(value)
    data << value
    heapify_up(index: data.size - 1)
    value
  end

  def delete
    return if data.empty?

    # Move last to first
    first_element = data.first
    last_element = data.pop

    unless data.empty?
      data[0] = last_element

      # this is needed when right index is nil and we don't swap in heapify_down
      hash[0] = last_element if data.size <= 3

      heapify_down(index: 0)
    end

    # delete last element in hash, this should be an orphan element
    hash.delete(data.size)

    first_element
  end

  def update(index:, new_value:)
    raise "Index #{index} is out of bounds" if index >= data.size

    old_value = data[index]

    return if new_value == old_value

    data[index] = new_value

    if new_value > old_value
      #heapify_down(index: 0)
      heapify_down(index:)

      # if new value remains in the same position update the hash index
      hash[index] = new_value if data[index] == new_value
    else
      heapify_up(index:)
    end
  end

  private

  def heapify_down(index:)
    left_index = left_child(index:)
    right_index = right_child(index:)

    smallest_index = index

    smallest_index = left_index if left_index < data.size && data[left_index] < data[smallest_index]
    smallest_index = right_index if right_index < data.size && data[right_index] < data[smallest_index]

    return unless smallest_index != index

    data[index], data[smallest_index] = data[smallest_index], data[index]
    hash[index] = data[index]
    hash[smallest_index] = data[smallest_index]

    heapify_down(index: smallest_index)
  end

  def heapify_up(index:)
    value = data[index]

    if index.zero?
      hash[index] = value
      return
    end

    parent_index = parent(index:)
    parent_value = data[parent_index]

    if parent_value <= value
      hash[index] = value unless hash.key?(index)
      return
    end

    # swap our value with our parent
    # Swap heapify_up until parent_value <= value
    data[index] = parent_value
    data[parent_index] = value

    # swap indexes in hash
    hash[parent_index] = value
    hash[index] = parent_value

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
