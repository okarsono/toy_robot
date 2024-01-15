# frozen_string_literal: true

require "highline"
require "i18n"

module ToyRobot
  class GameService
    def self.call
      new.call
    end

    attr_reader :prompter, :robot_service

    def initialize(output: $stdout)
      I18n.load_path += Dir["#{File.expand_path("config/locales")}/*.yml"]
      I18n.default_locale = :en

      @prompter = HighLine.new($stdin, output)
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
    rescue SignalException
      prompter.say label(".prompt.ending")
    end

    def read_command
      prompter.ask question
    rescue ToyRobot::Command::ImproperCommandError => e
      prompter.say e.message
      nil
    end

    private

    def process(command)
      command.robotic? ? process_robotic_command(command) : process_systemic_command(command)
    end

    def process_systemic_command(command)
      command.help? ? show_help : prompter.say(command.help_instructions)
    end

    def process_robotic_command(command)
      successful = robot_service.execute(command)
      ToyRobot.logger.info(successful ? "#{command.name} executed." : "#{command.name} is ignored.")
    rescue ToyRobot::Robot::InvalidRobotAttribute, NoMethodError => e
      ToyRobot.logger.error "Failed executing command: #{e.message}"
      prompter.say label(".failed_command", reason: e.message)
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

      Command::QUIT_COMMANDS.include? command.name
    end

    def label(key, **opts)
      I18n.t(key, **opts)
    end

    def show_help
      prompter.say label(".acceptable_instructions", commands: Command::VALID_COMMANDS.join("\n"))
    end
  end
end
