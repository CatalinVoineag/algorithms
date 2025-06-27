# frozen_string_literal: true

require 'byebug'

class MinHeap
  attr_accessor :data, :index_hash

  def initialize
    @data = []
    @index_hash = {}
  end

  def insert(hash)
    # {key: 'A', value: 1}
    data << hash
    heapify_up(index: data.size - 1)
    hash
  end

  def delete
    return if data.empty?

    # Move last to first
    first_element = data.first
    last_element = data.pop

    if data.any?
      data[0] = last_element
      index_hash.delete(first_element[:key])
      index_hash[last_element[:key]] = 0

      heapify_down(index: 0)
    else
      @index_hash = {}
    end

    first_element
  end

  def update(index:, new_hash:)
    raise "Index #{index} is out of bounds" if index >= data.size

    old_value = data[index].fetch(:value)
    new_value = new_hash.fetch(:value)
    new_key = new_hash.fetch(:key)

    return if new_value == old_value

    data[index] = new_hash

    if new_value > old_value
      heapify_down(index:)

      # { key: A}
      key = data[index][:key]

      # if new value remains in the same position update the hash index
      index_hash[key] = index if new_key == key
    else
      heapify_up(index:)
    end
  end

  private

  def heapify_down(index:)
    # Delete the head element, take last element, put it first and heapify_down
    left_index = left_child(index:)
    right_index = right_child(index:)

    smallest_index = index

    if left_index < data.size && data[left_index].fetch(:value) < data[smallest_index].fetch(:value)
      smallest_index = left_index
    end

    if right_index < data.size && data[right_index].fetch(:value) < data[smallest_index].fetch(:value)
      smallest_index = right_index
    end

    return unless smallest_index != index

    data[index], data[smallest_index] = data[smallest_index], data[index]

    # { key: A}
    key = data[index][:key]
    index_hash[key] = index
    smallest_key = data[smallest_index][:key]
    index_hash[smallest_key] = smallest_index

    heapify_down(index: smallest_index)
  end

  def heapify_up(index:)
    # { key: A}
    key = data[index][:key]

    if index.zero?
      index_hash[key] = index
      return
    end

    parent_index = parent(index:)
    parent_value = data[parent_index].fetch(:value)
    current_value = data[index].fetch(:value)

    if parent_value <= current_value
      index_hash[key] = index unless index_hash.key?(key)
      return
    end

    # swap our value with our parent
    # Swap heapify_up until parent_value <= value
    parent_hash = data[parent_index]
    parent_key = data[parent_index][:key]
    current_value_hash = data[index]

    data[index] = parent_hash
    data[parent_index] = current_value_hash

    index_hash[parent_key] = index
    index_hash[key] = parent_index

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
