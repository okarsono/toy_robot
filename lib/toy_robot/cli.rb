# frozen_string_literal: true

require "thor"

module ToyRobot
  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    desc "play", "Starts a new ToyRobot simulation"
    def play
      GameService.call
    end
  end
end
