# frozen_string_literal: true

RSpec.describe ToyRobot::Direction do
  describe "::parse" do
    it "returns the input if it is a valid direction" do
      expect(ToyRobot::Direction.parse("NORTH")).to eq "NORTH"
      expect(ToyRobot::Direction.parse("EAST")).to eq "EAST"
      expect(ToyRobot::Direction.parse("SOUTH")).to eq "SOUTH"
      expect(ToyRobot::Direction.parse("WEST")).to eq "WEST"
    end

    it "returns nil if input is not recognised" do
      expect(ToyRobot::Direction.parse("SOUTHEAST")).to be_nil
      expect(ToyRobot::Direction.parse("N")).to be_nil
    end
  end
end
