# frozen_string_literal: true

require "highline"
require "i18n"

module ToyRobot
  class GameService
    attr_reader :prompter

    def self.call
      new.call
    end

    def initialize
      I18n.load_path += Dir["#{File.expand_path("config/locales")}/*.yml"]
      I18n.default_locale = :en

      @prompter = HighLine.new
    end

    def call
      prompter.say label(".prompt.initial")
      show_help

      command = read_command

      until request_to_exit?(command)
        process(command)
        command = read_command
      end

      prompter.say label(".prompt.ending")
    end

    def process(command)
      command.help? ? show_help : prompter.say("You entered #{command.name}")
    end

    private

    def question
      string_to_command = lambda { |str|
        CommandValidator.validate(str)
      }
      @question ||= HighLine::Question.new(label(".prompt.command_cursor"), string_to_command) do |q|
        q.validate = CommandValidator
      end
    end

    def request_to_exit?(command)
      CommandValidator::QUIT_COMMANDS.include? command.name
    end

    def label(key, **opts)
      I18n.t(key, **opts)
    end

    def read_command
      prompter.ask question
    end

    def show_help
      prompter.say label(".acceptable_instructions", commands: CommandValidator::VALID_COMMANDS.join("\n"))
    end
  end
end
