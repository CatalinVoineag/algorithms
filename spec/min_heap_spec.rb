require "rspec"
require_relative "../min_heap"

RSpec.describe MinHeap do
  subject(:heap) { described_class.new }

  describe "insert and delete" do
    it "inserts and deletes correctly" do
      heap.insert(5)
      heap.insert(7)
      heap.insert(3)
      heap.insert(10)
      heap.insert(8)

      expect(heap.data).to eq([3, 7, 5, 10, 8])

      heap.delete
      expect(heap.data).to eq([5, 7, 8, 10])
      heap.delete
      expect(heap.data).to eq([7, 10, 8])
      heap.delete
      expect(heap.data).to eq([8, 10])

      heap.insert(1)

      expect(heap.data).to eq([1, 10, 8])

      heap.delete
      expect(heap.data).to eq([8, 10])
      heap.delete
      expect(heap.data).to eq([10])
      heap.delete
      expect(heap.data).to eq([])

      heap.insert(100)
      heap.insert(1)
      heap.insert(1)
      heap.insert(1)
      heap.insert(1)
      heap.insert(1)
      heap.insert(1)
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

  describe "update" do
    it "updates values in the heap" do
      heap.insert(5)
      heap.insert(7)
      heap.insert(3)
      heap.insert(10)
      heap.insert(8)

      expect(heap.data).to eq([3, 7, 5, 10, 8])

      heap.update(index: 1, value: 2)
      expect(heap.data).to eq([2, 3, 5, 10, 8])

      heap.update(index: 2, value: 4)
      expect(heap.data).to eq([2, 3, 4, 10, 8])

      heap.update(index: 4, value: 1)
      expect(heap.data).to eq([1, 2, 4, 10, 3])
    end
  end

  describe "test edge case" do
    it "insert and deletes correctly" do
      heap.insert(5)
      heap.insert(10)
      heap.insert(11)
      heap.insert(7)

      expect(heap.data).to eq([5, 7, 11, 10])
      heap.delete
      expect(heap.data).to eq([7, 10, 11])
      heap.delete
      expect(heap.data).to eq([10, 11])
      heap.delete
      expect(heap.data).to eq([11])
    end
  end
end
