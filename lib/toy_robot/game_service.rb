# frozen_string_literal: true

require "highline"
require "i18n"

module ToyRobot
  class GameService
    attr_reader :prompter, :robot_service

    def self.call
      new.call
    end

    def initialize
      I18n.load_path += Dir["#{File.expand_path("config/locales")}/*.yml"]
      I18n.default_locale = :en

      @prompter = HighLine.new
      @robot_service = RobotService.new
    end

    def call
      prompter.say label(".prompt.initial")
      show_help

      command = read_command

      until request_to_exit?(command)
        process(command) unless command.nil?
        command = read_command
      end

      prompter.say label(".prompt.ending")
    end

    private

    def process(command)
      return show_help if command.respond_to?(:help?) && command.help?

      return robot_service.execute(command) if command.respond_to?(:robotic?) && command.robotic?

      prompter.say("You entered #{command.name}")
      prompter.say command.help_instructions
    end

    def question
      string_to_command = lambda { |str|
        CommandValidator.validate(str)
      }
      @question ||= HighLine::Question.new(label(".prompt.command_cursor"), string_to_command) do |q|
        q.validate = CommandValidator
      end
    end

    def request_to_exit?(command)
      return false if command.nil?

      CommandValidator::QUIT_COMMANDS.include? command.name
    end

    def label(key, **opts)
      I18n.t(key, **opts)
    end

    def read_command
      prompter.ask question
    rescue ToyRobot::Command::ImproperCommandError => e
      prompter.say e.message
      nil
    end

    def show_help
      prompter.say label(".acceptable_instructions", commands: CommandValidator::VALID_COMMANDS.join("\n"))
    end
  end
end
