# frozen_string_literal: true

require "i18n"

module ToyRobot
  class Command
    class ImproperCommandError < StandardError; end

    QUIT_COMMANDS = %w(QUIT).freeze
    HELP_COMMANDS = %w(HELP).freeze

    SIMPLE_COMMANDS = %w(
      MOVE
      LEFT
      RIGHT
      REPORT
    ).freeze

    COMPLEX_COMMANDS = %w(PLACE).freeze

    ROBOTIC_COMMANDS = (SIMPLE_COMMANDS + COMPLEX_COMMANDS).freeze

    VALID_COMMANDS = (ROBOTIC_COMMANDS + HELP_COMMANDS + QUIT_COMMANDS).freeze

    def self.build(name, **opts)
      new(name, **opts)
    end

    def self.all
      VALID_COMMANDS
    end

    VALID_COMMANDS.each do |command_name|
      define_method("#{command_name.downcase}?") do
        command_name == @name
      end

      define_method("robotic?") do
        ROBOTIC_COMMANDS.include? @name
      end
    end

    attr_reader :name, :options

    def initialize(name, **opts)
      @name = name
      @options = opts
    end

    def help_instructions
      I18n.t(".command.#{name.downcase}")
    end
  end
end
