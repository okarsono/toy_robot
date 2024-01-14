# frozen_string_literal: true

RSpec.describe ToyRobot::RobotService do
  let(:robot_options) { { x: 0, y: 0, direction: "WEST" } }
  let(:command_name) { "MOVE" }
  let(:command_options) { {} }
  let(:command) { ToyRobot::Command.new(command_name, **command_options) }

  describe "#initialize_robot" do
    it "initializes a new instance of robot" do
      expect(subject.robot).to be_nil
      subject.initialize_robot(robot_options)
      expect(subject.robot).to be_a ToyRobot::Robot
    end

    context "invalid robot argument" do
      let(:robot_options) { {} }
      it "throws error" do
        expect { subject.initialize_robot(robot_options) }.to raise_error ToyRobot::Robot::InvalidRobotAttribute
      end
    end
  end

  describe "#execute" do
    context "no robot is initialized yet" do
      context "issuing PLACE command" do
        let(:command_name) { "PLACE" }
        let(:command_options) { robot_options }

        it "is truthy" do
          expect(subject.robot).to be_nil
          expect(subject.execute(command)).to be_truthy
        end
      end

      context "command other than PLACE" do
        it "is falsey" do
          expect(subject.robot).to be_nil
          expect(subject.execute(command)).to be_falsey
        end
      end
    end

    context "with existing robot" do
      before do
        subject.initialize_robot(robot_options)
      end

      context "issuing PLACE command" do
        let(:command_name) { "PLACE" }
        let(:command_options) { robot_options.merge(x: 4, direction: "SOUTH") }

        it "replaces the existing robot" do
          expect(subject.robot.direction).to eq robot_options[:direction]
          expect(subject.robot.x).to eq robot_options[:x]
          expect(subject.execute(command)).to be_truthy
          expect(subject.robot.x).to be 4
          expect(subject.robot.direction).to eq "SOUTH"
        end
      end
    end
  end
end
