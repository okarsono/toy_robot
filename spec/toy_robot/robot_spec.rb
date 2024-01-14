# frozen_string_literal: true

RSpec.describe ToyRobot::Robot do
  let(:direction) { "EAST" }
  let(:x_coordinate) { 1 }
  let(:y_coordinate) { 2 }
  let(:board_x_length) { 5 }
  let(:board_y_length) { 5 }
  let(:robot_options) { { board_x_length: board_x_length, board_y_length: board_y_length } }
  subject { described_class.new(x_coordinate, y_coordinate, direction, **robot_options) }

  describe "#new" do
    it "returns a new robot" do
      expect(subject).to be_a described_class
    end

    shared_examples_for "throwing error on invalid input" do
      it "throws an error" do
        expect { subject }.to raise_error ToyRobot::Robot::InvalidRobotAttribute
      end
    end

    context "invalid direction" do
      let(:direction) { "SOUTHWEST" }

      it_behaves_like "throwing error on invalid input"
    end

    context "negative coordinate" do
      let(:x_coordinate) { -2 }

      it_behaves_like "throwing error on invalid input"
    end

    context "coordinate as string" do
      let(:x_coordinate) { "3" }

      it_behaves_like "throwing error on invalid input"
    end

    context "initial x coordinate is outside the board" do
      let(:x_coordinate) { 5 }

      it_behaves_like "throwing error on invalid input"
    end

    context "initial y coordinate is outside the board" do
      let(:y_coordinate) { 6 }

      it_behaves_like "throwing error on invalid input"
    end

    context "invalid board size" do
      let(:board_x_length) { 0 }
      let(:x_coordinate) { 0 }

      it_behaves_like "throwing error on invalid input"
    end
  end

  describe "#left" do
    it "turns to the correct direction" do
      expect(subject.direction).to eq "EAST"
      subject.left
      expect(subject.direction).to eq "NORTH"
      subject.left
      expect(subject.direction).to eq "WEST"
      subject.left
      expect(subject.direction).to eq "SOUTH"
      subject.left
      expect(subject.direction).to eq "EAST"
    end
  end

  describe "#right" do
    it "turns to the correct direction" do
      expect(subject.direction).to eq "EAST"
      subject.right
      expect(subject.direction).to eq "SOUTH"
      subject.right
      expect(subject.direction).to eq "WEST"
      subject.right
      expect(subject.direction).to eq "NORTH"
      subject.right
      expect(subject.direction).to eq "EAST"
    end
  end

  describe "#move" do
    context "facing north" do
      let(:direction) { "NORTH" }

      it "goes up in y-axis" do
        expect(subject.direction).to eq direction
        expect(subject.y).to eq y_coordinate
        subject.move
        expect(subject.y).to eq y_coordinate + 1
      end

      context "on edge of board" do
        let(:y_coordinate) { board_y_length - 1 }

        it "does not move any further" do
          expect(subject.direction).to eq direction
          expect(subject.y).to eq y_coordinate
          subject.move
          expect(subject.y).to eq y_coordinate
        end
      end
    end

    context "facing south" do
      let(:direction) { "SOUTH" }

      it "goes down in y-axis" do
        expect(subject.direction).to eq direction
        expect(subject.y).to eq y_coordinate
        subject.move
        expect(subject.y).to eq y_coordinate - 1
      end

      context "on edge of board" do
        let(:y_coordinate) { 0 }

        it "does not move any further" do
          expect(subject.direction).to eq direction
          expect(subject.y).to eq y_coordinate
          subject.move
          expect(subject.y).to eq y_coordinate
        end
      end
    end

    context "facing east" do
      let(:direction) { "EAST" }

      it "goes up in x-axis" do
        expect(subject.direction).to eq direction
        expect(subject.x).to eq x_coordinate
        subject.move
        expect(subject.x).to eq x_coordinate + 1
      end

      context "on edge of board" do
        let(:x_coordinate) { board_x_length - 1 }

        it "does not move any further" do
          expect(subject.direction).to eq direction
          expect(subject.x).to eq x_coordinate
          subject.move
          expect(subject.x).to eq x_coordinate
        end
      end
    end

    context "facing west" do
      let(:direction) { "WEST" }

      it "goes down in x-axis" do
        expect(subject.direction).to eq direction
        expect(subject.x).to eq x_coordinate
        subject.move
        expect(subject.x).to eq x_coordinate - 1
      end

      context "on edge of board" do
        let(:x_coordinate) { 0 }

        it "does not move any further" do
          expect(subject.direction).to eq direction
          expect(subject.x).to eq x_coordinate
          subject.move
          expect(subject.x).to eq x_coordinate
        end
      end
    end
  end
end
