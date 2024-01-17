# frozen_string_literal: true

RSpec.describe ToyRobot::CLI do
  describe "#play" do
    it "recognises play method" do
      expect(subject.respond_to?(:play)).to be_truthy
    end

    context "with extra argument" do
      context "input file" do
        let(:fd_spy) { instance_double File }

        before do
          allow(File).to receive(:open).with(filename, "r") { fd_spy }
        end

        context "real file" do
          let(:filename) { "sample_input.txt" }

          it "uses that instead of standard input" do
            expect(File.file?(filename)).to be_truthy
            expect(ToyRobot::GameService).to receive(:call).with(input: fd_spy).exactly(:once)

            subject.invoke(:play, [], { "in" => filename })
          end
        end

        context "non-existent filename" do
          let(:filename) { "imaginary_file.txt" }

          it "prints friendly error message and terminates" do
            expect(ToyRobot::GameService).not_to receive(:call)
            expect do
              subject.invoke(:play, [], { "in" => filename })
            end.to output(/Error: input is not a valid file/).to_stdout
          end
        end
      end
    end
  end
end
