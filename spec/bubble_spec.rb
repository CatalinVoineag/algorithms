require "rspec"
require_relative "../bubble"

RSpec.describe Bubble do
  describe "#sort" do
    it "sorts the array" do
      array = [9, 3, 7, 4, 69, 420, 42]

      expect(described_class.new.sort(array)).to eq(
        [3, 4, 7, 9, 42, 69, 420]
      )
    end
  end
end
