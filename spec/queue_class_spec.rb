require "rspec"
require_relative "../queue_class"

RSpec.describe QueueClass do
  describe "test" do
    it "tests the queue" do
      queue = described_class.new

      queue.enqueue(1)
      queue.enqueue(2)
      queue.enqueue(3)

      expect(queue.deque).to eq(1)
      expect(queue.length).to eq(2)

      queue.deque
      queue.deque
      expect(queue.length).to eq(0)


      queue.enqueue(69)
      expect(queue.peek).to eq(69)
    end
  end
end
