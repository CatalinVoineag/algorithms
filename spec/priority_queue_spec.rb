# frozen_string_literal: true

require 'rspec'
require_relative '../priority_queue'

RSpec.describe PriorityQueue do
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

  describe 'index keeping' do
    it 'updates the indexes correctly' do
      heap.insert(50)
      heap.insert(71)
      heap.insert(100)
      heap.insert(101)
      heap.insert(80)
      heap.insert(200)
      heap.insert(105)

      expect(heap.data).to eq([50, 71, 100, 101, 80, 200, 105])
      expect(heap.hash).to eq(
        { 0 => 50, 1 => 71, 2 => 100, 3 => 101, 4 => 80, 5 => 200, 6 => 105 }
      )

      heap.delete
      expect(heap.data).to eq([71, 80, 100, 101, 105, 200])
      expect(heap.hash).to eq(
        { 0 => 71, 2 => 100, 3 => 101, 1 => 80, 5 => 200, 4 => 105 }
      )

      heap.delete
      expect(heap.data).to eq([80, 101, 100, 200, 105])
      expect(heap.hash).to eq(
        { 2 => 100, 1 => 101, 0 => 80, 3 => 200, 4 => 105 }
      )

      heap.delete
      expect(heap.data).to eq([100, 101, 105, 200])
      expect(heap.hash).to eq(
        { 0 => 100, 1 => 101, 3 => 200, 2 => 105 }
      )

      heap.delete
      expect(heap.data).to eq([101, 200, 105])
      expect(heap.hash).to eq(
        { 0 => 101, 1 => 200, 2 => 105 }
      )

      heap.delete
      expect(heap.data).to eq([105, 200])
      expect(heap.hash).to eq(
        { 1 => 200, 0 => 105 }
      )

      heap.delete
      expect(heap.data).to eq([200])
      expect(heap.hash).to eq(
        { 0 => 200 }
      )

      heap.delete
      expect(heap.data).to eq([])
      expect(heap.hash).to eq({})
    end
  end

  describe 'update' do
    it 'updates the values correctly' do
      heap.insert(50)
      heap.insert(71)
      heap.insert(100)
      heap.insert(101)
      heap.insert(80)
      heap.insert(200)
      heap.insert(105)

      expect(heap.data).to eq([50, 71, 100, 101, 80, 200, 105])

      heap.update(index: 0, new_value: 51)

      expect(heap.data).to eq([51, 71, 100, 101, 80, 200, 105])
      expect(heap.hash).to eq(
        { 0 => 51, 1 => 71, 2 => 100, 3 => 101, 4 => 80, 5 => 200, 6 => 105 }
      )

      heap.update(index: 4, new_value: 21)

      expect(heap.data).to eq([21, 51, 100, 101, 71, 200, 105])
      expect(heap.hash).to eq(
        { 0 => 21, 1 => 51, 2 => 100, 3 => 101, 4 => 71, 5 => 200, 6 => 105 }
      )

      heap.update(index: 5, new_value: 202)

      expect(heap.data).to eq([21, 51, 100, 101, 71, 202, 105])
      expect(heap.hash).to eq(
        { 0 => 21, 1 => 51, 2 => 100, 3 => 101, 4 => 71, 5 => 202, 6 => 105 }
      )

      heap.update(index: 6, new_value: 2)

      expect(heap.data).to eq([2, 51, 21, 101, 71, 202, 100])
      expect(heap.hash).to eq(
        { 0 => 2, 1 => 51, 2 => 21, 3 => 101, 4 => 71, 5 => 202, 6 => 100 }
      )

      heap.update(index: 0, new_value: 1)

      expect(heap.data).to eq([1, 51, 21, 101, 71, 202, 100])
      expect(heap.hash).to eq(
        { 0 => 1, 1 => 51, 2 => 21, 3 => 101, 4 => 71, 5 => 202, 6 => 100 }
      )

      heap.update(index: 0, new_value: 100)

      expect(heap.data).to eq([21, 51, 100, 101, 71, 202, 100])
      expect(heap.hash).to eq(
        { 0 => 21, 1 => 51, 2 => 100, 3 => 101, 4 => 71, 5 => 202, 6 => 100 }
      )

      expect { heap.update(index: 200, new_value: 100) }
        .to raise_error(RuntimeError, 'Index 200 is out of bounds')
    end

    it 'updates edge case' do
      heap.insert(10)
      heap.insert(20)
      heap.insert(30)
      heap.insert(40)

      expect(heap.data).to eq([10, 20, 30, 40])

      heap.update(index: 1, new_value: 50)
      expect(heap.data).to eq([10, 40, 30, 50])
    end
  end
end
