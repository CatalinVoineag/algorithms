require "rspec"
require_relative "../stack"

RSpec.describe Stack do
  describe "stack" do
    it "tests the stack" do
      stack = described_class.new 

      stack.push(1)
      stack.push(2)
      stack.push(3)

      expect(stack.length).to eq(3)
      expect(stack.peek).to eq(3)

      expect(stack.pop).to eq(3)

      expect(stack.length).to eq(2)
      expect(stack.peek).to eq(2)

      expect(stack.pop).to eq(2)
      expect(stack.pop).to eq(1)
      expect(stack.peek).to eq(nil)
      expect(stack.pop).to eq(nil)
    end
  end
end
