require 'benchmark'

def test
  array_sizes = [10_000, 100_000, 1_000_000, 10_000_000, 100_000_000]

  array_sizes.each do |array_size|
    array = Array.new(array_size, 1)

    puts Benchmark.measure { array + Array.new(array_size, 2)}
  end
end

test
