# frozen_string_literal: true

require 'byebug'
require_relative 'min_heap'

class Dijkstra
  def call(start:, end_value:, graph:)
    heap = MinHeap.new
    heap.index_hash
    distance = Hash.new(Float::INFINITY)
    previous = {}

    distance[start] = 0

    graph.each_key do |key|
      heap.insert({ key:, value: distance[key] })
    end

    until heap.data.empty?
      current_step = heap.delete
      current_key = current_step[:key]
      current_step[:value]

      break if current_key == end_value

      graph[current_key].each do |(link, weight)|
        alternative = distance[current_key] + weight

        next unless alternative < distance[link]

        distance[link] = alternative
        previous[link] = current_key

        heap.update(
          index: heap.index_hash[link],
          new_hash: {
            key: link,
            value: alternative
          }
        )
      end
    end

    path = []
    node = end_value
    while node
      path << node
      node = previous[node]
    end
    path.reverse
  end
end
graph = {
  'S' => [['A', 7], ['B', 2], ['C', 3]],
  'A' => [['S', 7], ['B', 3], ['D', 4]],
  'B' => [['S', 2], ['A', 3], ['D', 4], ['H', 1]],
  'C' => [['S', 3], ['L', 2]],
  'D' => [['A', 4], ['B', 4], ['F', 5]],
  'F' => [['D', 5], ['H', 3]],
  'H' => [['B', 1], ['F', 3], ['G', 2]],
  'G' => [['H', 2], ['E', 2]],
  'E' => [['G', 2], ['K', 5]],
  'L' => [['C', 2], ['I', 4], ['J', 6]],
  'I' => [['L', 4], ['J', 4], ['K', 5]],
  'J' => [['L', 6], ['I', 4], ['K', 4]],
  'K' => [['J', 4], ['I', 5], ['E', 5]]
}

puts Dijkstra.new.call(start: 'S', end_value: 'A', graph:)
