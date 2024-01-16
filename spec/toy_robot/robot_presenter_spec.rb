# frozen_string_literal: true

RSpec.describe ToyRobot::RobotPresenter do
  let(:x) { 2 }
  let(:y) { 3 }
  let(:direction) { "SOUTH" }
  let(:robot) { ToyRobot::Robot.new(x, y, direction) }

  subject { described_class.new(robot) }

  describe "#report" do
    def expect_output_matches_full_format(output)
      expect(output).to eq "Robot is at [#{robot.x},#{robot.y}] facing #{robot.direction}"
    end

    context "no format is supplied" do
      it "returns output in full format" do
        expect_output_matches_full_format(subject.report)
      end
    end

    context "selected format" do
      context "short" do
        it "returns output in short format" do
          expect(subject.report(:short)).to eq "[#{robot.x},#{robot.y}] facing #{robot.direction}"
        end
      end

      context "csv" do
        it "returns output in simple format" do
          expect(subject.report(:csv)).to eq "[#{robot.x},#{robot.y},#{robot.direction}]"
        end
      end

      context "invalid format" do
        it "returns output in simple format" do
          expect_output_matches_full_format(subject.report("pdf"))
        end
      end
    end
  end
end
