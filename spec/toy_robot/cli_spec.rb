# frozen_string_literal: true

RSpec.describe ToyRobot::CLI do
  describe "#play"
  it "recognises play method" do
    expect(described_class.new.respond_to?(:play)).to be_truthy
  end
end
