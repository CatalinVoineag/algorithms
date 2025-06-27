# frozen_string_literal: true

require 'rspec'
require_relative '../min_heap'

RSpec.describe MinHeap do
  subject(:heap) { described_class.new }

  describe 'insert and delete' do
    it 'inserts and deletes correctly' do
      heap.insert({ key: 'A', value: 5 })
      heap.insert({ key: 'B', value: 7 })
      heap.insert({ key: 'C', value: 3 })
      heap.insert({ key: 'D', value: 10 })
      heap.insert({ key: 'E', value: 8 })

      expect(heap.data).to eq(
        [
          { key: 'C', value: 3 },
          { key: 'B', value: 7 },
          { key: 'A', value: 5 },
          { key: 'D', value: 10 },
          { key: 'E', value: 8 }
        ]
      )

      heap.delete
      expect(heap.data).to eq(
        [
          { key: 'A', value: 5 },
          { key: 'B', value: 7 },
          { key: 'E', value: 8 },
          { key: 'D', value: 10 }
        ]
      )
      heap.delete
      expect(heap.data).to eq(
        [
          { key: 'B', value: 7 },
          { key: 'D', value: 10 },
          { key: 'E', value: 8 }
        ]
      )
      heap.delete
      expect(heap.data).to eq(
        [
          { key: 'E', value: 8 },
          { key: 'D', value: 10 }
        ]
      )

      heap.insert({ key: 'A', value: 1 })

      expect(heap.data).to eq(
        [
          { key: 'A', value: 1 },
          { key: 'D', value: 10 },
          { key: 'E', value: 8 }
        ]
      )

      heap.delete
      expect(heap.data).to eq(
        [
          { key: 'E', value: 8 },
          { key: 'D', value: 10 }
        ]
      )
      heap.delete
      expect(heap.data).to eq([{ key: 'D', value: 10 }])
      heap.delete
      expect(heap.data).to eq([])

      heap.insert({ key: 'A', value: 100 })
      heap.insert({ key: 'B', value: 1 })
      heap.insert({ key: 'C', value: 1 })
      heap.insert({ key: 'D', value: 1 })
      heap.insert({ key: 'E', value: 1 })
      heap.insert({ key: 'F', value: 1 })
      heap.insert({ key: 'G', value: 1 })
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

  describe 'test edge case' do
    it 'insert and deletes correctly' do
      heap.insert({ key: 'A', value: 5 })
      heap.insert({ key: 'B', value: 10 })
      heap.insert({ key: 'C', value: 11 })
      heap.insert({ key: 'D', value: 7 })

      expect(heap.data).to eq(
        [
          { key: 'A', value: 5 },
          { key: 'D', value: 7 },
          { key: 'C', value: 11 },
          { key: 'B', value: 10 }
        ]
      )
      heap.delete
      expect(heap.data).to eq(
        [
          { key: 'D', value: 7 },
          { key: 'B', value: 10 },
          { key: 'C', value: 11 }
        ]
      )
      heap.delete
      expect(heap.data).to eq(
        [
          { key: 'B', value: 10 },
          { key: 'C', value: 11 }
        ]
      )
      heap.delete
      expect(heap.data).to eq([{ key: 'C', value: 11 }])
    end
  end

  describe 'index keeping' do
    it 'updates the indexes correctly' do
      heap.insert({ key: 'A', value: 50 })
      heap.insert({ key: 'B', value: 71 })
      heap.insert({ key: 'C', value: 100 })
      heap.insert({ key: 'D', value: 101 })
      heap.insert({ key: 'E', value: 80 })
      heap.insert({ key: 'F', value: 200 })
      heap.insert({ key: 'G', value: 105 })

      expect(heap.data).to eq(
        [
          { key: 'A', value: 50 },
          { key: 'B', value: 71 },
          { key: 'C', value: 100 },
          { key: 'D', value: 101 },
          { key: 'E', value: 80 },
          { key: 'F', value: 200 },
          { key: 'G', value: 105 }
        ]
      )

      expect(heap.index_hash).to eq(
        {
          'A' => 0,
          'B' => 1,
          'C' => 2,
          'D' => 3,
          'E' => 4,
          'F' => 5,
          'G' => 6
        }
      )

      heap.delete
      expect(heap.data).to eq(
        [
          { key: 'B', value: 71 },
          { key: 'E', value: 80 },
          { key: 'C', value: 100 },
          { key: 'D', value: 101 },
          { key: 'G', value: 105 },
          { key: 'F', value: 200 }
        ]
      )
      expect(heap.index_hash).to eq(
        {
          # 0 => { key: 'B', value: 71 },
          # 2 => { key: 'C', value: 100 },
          # 3 => { key: 'D', value: 101 },
          # 1 => { key: 'E', value: 80 },
          # 5 => { key: 'F', value: 200 },
          # 4 => { key: 'G', value: 105 },

          'B' => 0,
          'C' => 2,
          'D' => 3,
          'E' => 1,
          'F' => 5,
          'G' => 4

          # 0 => { key: 'B', value: 71 },
          # 2 => { key: 'C', value: 100 },
          # 3 => { key: 'D', value: 101 },
          # 1 => { key: 'E', value: 80 },
          # 5 => { key: 'F', value: 200 },
          # 4 => { key: 'G', value: 105 },
        }
      )

      heap.delete
      expect(heap.data).to eq(
        [
          { key: 'E', value: 80 },
          { key: 'D', value: 101 },
          { key: 'C', value: 100 },
          { key: 'F', value: 200 },
          { key: 'G', value: 105 }
        ]
      )
      expect(heap.index_hash).to eq(
        {

          'C' => 2,
          'D' => 1,
          'E' => 0,
          'F' => 3,
          'G' => 4
        }
      )

      heap.delete
      expect(heap.data).to eq(
        [
          { key: 'C', value: 100 },
          { key: 'D', value: 101 },
          { key: 'G', value: 105 },
          { key: 'F', value: 200 }
        ]
      )
      expect(heap.index_hash).to eq(
        {
          'C' => 0,
          'D' => 1,
          'F' => 3,
          'G' => 2
        }
      )

      heap.delete
      expect(heap.data).to eq(
        [
          { key: 'D', value: 101 },
          { key: 'F', value: 200 },
          { key: 'G', value: 105 }
        ]
      )
      expect(heap.index_hash).to eq(
        {
          'D' => 0,
          'F' => 1,
          'G' => 2
        }
      )

      heap.delete
      expect(heap.data).to eq(
        [
          { key: 'G', value: 105 },
          { key: 'F', value: 200 }
        ]
      )
      expect(heap.index_hash).to eq(
        {
          'F' => 1,
          'G' => 0
        }
      )

      heap.delete
      expect(heap.data).to eq(
        [
          { key: 'F', value: 200 }
        ]
      )
      expect(heap.index_hash).to eq(
        {
          'F' => 0
        }
      )

      heap.delete
      expect(heap.data).to eq([])
      expect(heap.index_hash).to eq({})
    end
  end

  describe 'update' do
    it 'updates the values correctly' do
      heap.insert({ key: 'A', value: 50 })
      heap.insert({ key: 'B', value: 71 })
      heap.insert({ key: 'C', value: 100 })
      heap.insert({ key: 'D', value: 101 })
      heap.insert({ key: 'E', value: 80 })
      heap.insert({ key: 'F', value: 200 })
      heap.insert({ key: 'G', value: 105 })

      expect(heap.data).to eq(
        [
          { key: 'A', value: 50 },
          { key: 'B', value: 71 },
          { key: 'C', value: 100 },
          { key: 'D', value: 101 },
          { key: 'E', value: 80 },
          { key: 'F', value: 200 },
          { key: 'G', value: 105 }
        ]
      )

      heap.update(index: 0, new_hash: { key: 'A', value: 51 })
      expect(heap.data).to eq(
        [
          { key: 'A', value: 51 },
          { key: 'B', value: 71 },
          { key: 'C', value: 100 },
          { key: 'D', value: 101 },
          { key: 'E', value: 80 },
          { key: 'F', value: 200 },
          { key: 'G', value: 105 }
        ]
      )
      expect(heap.index_hash).to eq(
        {
          'A' => 0,
          'B' => 1,
          'C' => 2,
          'D' => 3,
          'E' => 4,
          'F' => 5,
          'G' => 6
        }
      )

      heap.update(index: 4, new_hash: { key: 'E', value: 21 })
      expect(heap.data).to eq(
        [
          { key: 'E', value: 21 },
          { key: 'A', value: 51 },
          { key: 'C', value: 100 },
          { key: 'D', value: 101 },
          { key: 'B', value: 71 },
          { key: 'F', value: 200 },
          { key: 'G', value: 105 }
        ]
      )
      expect(heap.index_hash).to eq(
        {
          'A' => 1,
          'B' => 4,
          'C' => 2,
          'D' => 3,
          'E' => 0,
          'F' => 5,
          'G' => 6
        }
      )

      heap.update(index: 5, new_hash: { key: 'F', value: 202 })
      expect(heap.data).to eq(
        [
          { key: 'E', value: 21 },
          { key: 'A', value: 51 },
          { key: 'C', value: 100 },
          { key: 'D', value: 101 },
          { key: 'B', value: 71 },
          { key: 'F', value: 202 },
          { key: 'G', value: 105 }
        ]
      )
      expect(heap.index_hash).to eq(
        {
          'A' => 1,
          'B' => 4,
          'C' => 2,
          'D' => 3,
          'E' => 0,
          'F' => 5,
          'G' => 6
        }
      )

      heap.update(index: 6, new_hash: { key: 'G', value: 2 })
      expect(heap.data).to eq(
        [
          { key: 'G', value: 2 },
          { key: 'A', value: 51 },
          { key: 'E', value: 21 },
          { key: 'D', value: 101 },
          { key: 'B', value: 71 },
          { key: 'F', value: 202 },
          { key: 'C', value: 100 }
        ]
      )
      expect(heap.index_hash).to eq(
        {
          'A' => 1,
          'B' => 4,
          'C' => 6,
          'D' => 3,
          'E' => 2,
          'F' => 5,
          'G' => 0
        }
      )

      heap.update(index: 0, new_hash: { key: 'G', value: 1 })
      expect(heap.data).to eq(
        [
          { key: 'G', value: 1 },
          { key: 'A', value: 51 },
          { key: 'E', value: 21 },
          { key: 'D', value: 101 },
          { key: 'B', value: 71 },
          { key: 'F', value: 202 },
          { key: 'C', value: 100 }
        ]
      )
      expect(heap.index_hash).to eq(
        {
          'A' => 1,
          'B' => 4,
          'C' => 6,
          'D' => 3,
          'E' => 2,
          'F' => 5,
          'G' => 0
        }
      )

      heap.update(index: 0, new_hash: { key: 'G', value: 100 })
      expect(heap.data).to eq(
        [
          { key: 'E', value: 21 },
          { key: 'A', value: 51 },
          { key: 'G', value: 100 },
          { key: 'D', value: 101 },
          { key: 'B', value: 71 },
          { key: 'F', value: 202 },
          { key: 'C', value: 100 }
        ]
      )
      expect(heap.index_hash).to eq(
        {
          'A' => 1,
          'B' => 4,
          'C' => 6,
          'D' => 3,
          'E' => 0,
          'F' => 5,
          'G' => 2
        }
      )

      expect { heap.update(index: 200, new_hash: { key: 'G', value: 100 }) }
        .to raise_error(RuntimeError, 'Index 200 is out of bounds')
    end

    it 'updates edge case' do
      heap.insert({ key: 'A', value: 10 })
      heap.insert({ key: 'B', value: 20 })
      heap.insert({ key: 'C', value: 30 })
      heap.insert({ key: 'D', value: 40 })

      expect(heap.data).to eq(
        [
          { key: 'A', value: 10 },
          { key: 'B', value: 20 },
          { key: 'C', value: 30 },
          { key: 'D', value: 40 }
        ]
      )

      heap.update(index: 1, new_hash: { key: 'B', value: 50 })
      expect(heap.data).to eq(
        [
          { key: 'A', value: 10 },
          { key: 'D', value: 40 },
          { key: 'C', value: 30 },
          { key: 'B', value: 50 }
        ]
      )
      expect(heap.index_hash).to eq(
        {
          'A' => 0,
          'B' => 3,
          'C' => 2,
          'D' => 1
        }
      )
    end
  end
end
