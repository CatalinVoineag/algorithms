require "rspec"
require_relative "../two_crystal_balls"

RSpec.describe TwoCrystalBalls do
  describe "#find_index_where_they_break" do
    it "finds the index of true" do
      index = (rand * 10000).floor
      array = Array.new(10000, false)
      i = index 
      while i < 10000
        array[i] = true
        i += 1
      end

      expect(described_class.new.find_index_where_they_break(array)).to eq(index)
    end

    context "when array does not have true" do
      it "returns nil" do
        array = Array.new(10000, false)

        expect(described_class.new.find_index_where_they_break(array)).to eq(nil)
      end
    end
  end
end
