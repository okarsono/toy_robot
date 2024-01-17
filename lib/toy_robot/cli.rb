# frozen_string_literal: true

require "thor"

module ToyRobot
  class CLI < Thor
    class InvalidInputStreamError < StandardError; end

    def self.exit_on_failure?
      true
    end

    desc "play", "Starts a new ToyRobot simulation"
    method_option :in, type: :string, banner: "input.txt", desc: I18n.t(".play_options.input")
    def play
      input_stream = options.fetch("in", "").empty? ? $stdin : open_file(options["in"])
      GameService.call(input: input_stream)
    rescue InvalidInputStreamError => e
      puts e.message
      puts "Need help? Run: toy_robot help play"
    ensure
      input_stream.close if input_stream.is_a?(File) && !input_stream.closed?
    end

    private

    def open_file(input_file)
      raise InvalidInputStreamError, "Error: input is not a valid file" unless File.file?(input_file)

      File.open(input_file, "r")
    rescue Errno::ENOENT, Errno::EACCES
      raise InvalidInputStreamError, "Error: unable to open file for reading"
    end
  end
end
