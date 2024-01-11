# frozen_string_literal: true

RSpec.describe ToyRobot do
  it "has a version number" do
    expect(ToyRobot::VERSION).not_to be nil
  end

  it "has a command line interface" do
    expect { described_class::CLI }.not_to raise_error
  end
end
