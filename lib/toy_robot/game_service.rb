# frozen_string_literal: true

require "highline"
# require 'i18n'

module ToyRobot
  class GameService
    EXIT_COMMANDS = %w(exit quit).freeze

    attr_reader :prompter

    def self.call
      new.call
    end

    def initialize
      @prompter = HighLine.new
    end

    def call
      prompter.say "Robot at your service. Please enter your command"

      command = prompter.ask "> "
      until request_to_exit?(command)
        prompter.say "You entered #{command}"
        command = prompter.ask "> "
      end

      prompter.say "Thank you for playing."
    end

    private

    def request_to_exit?(input)
      EXIT_COMMANDS.include? input.downcase
    end
  end
end
