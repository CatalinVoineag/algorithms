require "rspec"
require_relative "../min_heap"

RSpec.describe MinHeap do
  subject(:heap) { described_class.new }

  describe "insert and delete" do
    it "inserts and deletes correctly" do
      heap.insert(value: 5)
      heap.insert(value: 7)
      heap.insert(value: 3)
      heap.insert(value: 10)
      heap.insert(value: 8)

      expect(heap.data).to eq([3, 7, 5, 10, 8])

      heap.delete
      expect(heap.data).to eq([5, 7, 8, 10])
      heap.delete
      expect(heap.data).to eq([7, 10, 8])
      heap.delete
      expect(heap.data).to eq([8, 10])

      heap.insert(value: 1)

      expect(heap.data).to eq([1, 10, 8])

      heap.delete
      expect(heap.data).to eq([8, 10])
      heap.delete
      expect(heap.data).to eq([10])
      heap.delete
      expect(heap.data).to eq([])

      heap.insert(value: 100)
      heap.insert(value: 1)
      heap.insert(value: 1)
      heap.insert(value: 1)
      heap.insert(value: 1)
      heap.insert(value: 1)
      heap.insert(value: 1)
      heap.delete
      heap.delete
      heap.delete
      heap.delete
      heap.delete
      heap.delete
      heap.delete
      expect(heap.data).to eq([])
    end
  end
end
