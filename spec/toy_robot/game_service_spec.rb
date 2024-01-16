# frozen_string_literal: true

RSpec.describe ToyRobot::GameService do
  let(:game_service_output) { StringIO.new }
  subject { described_class.new(output: game_service_output) }

  describe "#call" do
    it "exits the application on QUIT command" do
      expect(subject).to receive(:read_command).exactly(:once) { ToyRobot::Command.new("QUIT") }
      subject.call
      expect(game_service_output.string).to match(/Thank you for playing/)
    end

    it "exits the application gracefully on interrupt signal (Ctrl+C)" do
      allow(subject).to receive(:show_help) { raise SignalException, "INT" }

      expect do
        subject.call
      end.not_to raise_error
      expect(game_service_output.string).to match(/Thank you for playing/)
    end
  end

  context "integration test" do
    context "input combination of commands" do
      let(:inputs) do
        [
          "PLACE 1,2,EAST",
          "MOVE",
          "RIGHT",
          "REPORT",
          "QUIT"
        ]
      end
      let(:commands) { inputs.map { |str| ToyRobot::CommandValidator.validate(str) } }

      it "reports the robot final position correctly" do
        robot_final_report = "Robot is at [2,2] facing SOUTH"
        expected_output = "Thank you for playing"

        expect(subject).to receive(:read_command).exactly(inputs.size).times.and_return(*commands)

        expect { subject.call }.not_to raise_error
        expect(game_service_output.string).to include(expected_output)
        expect(game_service_output.string).to include(robot_final_report)
      end
    end
  end
end
