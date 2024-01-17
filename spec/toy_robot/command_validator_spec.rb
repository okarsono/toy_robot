# frozen_string_literal: true

RSpec.describe ToyRobot::CommandValidator do
  describe "::validate" do
    let(:throw_command) { ToyRobot::Command.new("THROW", thing: "ROCK", size: :medium) }

    before do
      stub_const("ToyRobot::Command::SIMPLE_COMMANDS", %w(WALK RUN JUMP))
      stub_const("ToyRobot::Command::COMPLEX_COMMANDS", %w(THROW))

      allow(described_class).to receive(:try_throw_command) { nil }
      allow(described_class).to receive(:try_throw_command).with("THROW MEDIUM ROCK") { throw_command }
    end

    context "recognized commands" do
      it "converts string input into command object" do
        output = described_class.validate("WALK")
        expect(output).to be_a ToyRobot::Command
        expect(output.name).to eq "WALK"

        output = described_class.validate("RUN")
        expect(output).to be_a ToyRobot::Command
        expect(output.name).to eq "RUN"

        output = described_class.validate("JUMP")
        expect(output).to be_a ToyRobot::Command
        expect(output.name).to eq "JUMP"

        output = described_class.validate("THROW MEDIUM ROCK")
        expect(output).to be_a ToyRobot::Command
        expect(output.name).to eq "THROW"
        expect(output.options).to eq({ thing: "ROCK", size: :medium })

        output = described_class.validate("HELP")
        expect(output).to be_a ToyRobot::Command
        expect(output.name).to eq "HELP"

        output = described_class.validate("QUIT")
        expect(output).to be_a ToyRobot::Command
        expect(output.name).to eq "QUIT"
      end
    end

    context "incomplete commands" do
      it "returns nil" do
        expect(described_class.validate("THROW")).to be_nil
      end
    end

    context "commands with invalid parameters" do
      it "returns nil" do
        expect(described_class.validate("THROW RESPONSIBILITY")).to be_nil
      end
    end

    context "unrecognized commands" do
      it "returns nil" do
        expect(described_class.validate("DANCE")).to be_nil
      end
    end
  end

  describe "::try_place_command" do
    context "with valid parameters" do
      it "constructs and returns place command" do
        command = described_class.try_place_command("PLACE 1,2,SOUTH")
        expect(command.name).to eq "PLACE"
        expect(command.options).to eq({ x: 1, y: 2, direction: "SOUTH" })

        command = described_class.try_place_command("PLACE 1,20,EAST")
        expect(command.name).to eq "PLACE"
        expect(command.options).to eq({ x: 1, y: 20, direction: "EAST" })
      end
    end

    context "with parameters not matching expected pattern" do
      it "raises error with hint to help" do
        ["PLACE", "PLACE 1, 2, SOUTH", "PLACE IN MY HEART"].each do |command_string|
          expect do
            described_class.try_place_command(command_string)
          end.to raise_error ToyRobot::Command::ImproperCommandError, "invalid PLACE command. Try HELP PLACE for help"
        end
      end
    end
  end
end
