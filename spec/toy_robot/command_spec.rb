# frozen_string_literal: true

RSpec.describe ToyRobot::Command do
  let(:command_name) { "RUN" }
  let(:command_options) { { distance: 3, unit: :km } }

  describe "::build" do
    subject { described_class.build(command_name, **command_options) }

    it "builds and returns an instance" do
      expect(subject).to be_a described_class
    end

    it "returns an instance with the same name" do
      expect(subject.name).to eq command_name
    end

    it "returns an instance with the same options as its argument" do
      expect(subject.options).to eq command_options
    end
  end

  describe ".new" do
    subject { described_class.new(command_name, **command_options) }

    it "returns an instance with the same name" do
      expect(subject.name).to eq command_name
    end

    it "returns an instance with the same options as its argument" do
      expect(subject.options).to eq command_options
    end
  end

  describe "#help_instructions" do
    let(:tips) { "Run to the moon" }

    subject { described_class.new(command_name, **command_options) }

    it "returns the text in the locale" do
      allow(I18n).to receive(:t).with(".command.#{command_name.downcase}") { tips }
      expect(subject.help_instructions).to eq tips
    end
  end
end
