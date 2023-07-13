require "rspec"
require_relative "../binary_search"

RSpec.describe BinarySearch do
  describe "#search" do
    it "finds number 4" do
      array = [1,2,3,4,5,6,7,8,9,10]

      expect(described_class.new.search(
        array: array,
        number: 4
      )).to eq(4)
    end

    context "when number is not in array" do
      it "returns nil" do
        array = [1,2,3,4,5,6,7,8,9,10]

        expect(described_class.new.search(
          array: array,
          number: 69
        )).to eq(nil)
      end
    end
  end
end
