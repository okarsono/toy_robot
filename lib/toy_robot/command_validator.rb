# frozen_string_literal: true

module ToyRobot
  class CommandValidator
    QUIT_COMMANDS = %w(EXIT QUIT).freeze
    HELP_COMMANDS = %w(HELP).freeze

    SIMPLE_COMMANDS = %w(
      MOVE
      LEFT
      RIGHT
      REPORT
    ).freeze

    COMPLEX_COMMANDS = %w(PLACE).freeze

    VALID_COMMANDS = (SIMPLE_COMMANDS + COMPLEX_COMMANDS + HELP_COMMANDS + QUIT_COMMANDS).freeze

    def self.validate(user_input)
      return Command.new(user_input) if (SIMPLE_COMMANDS + QUIT_COMMANDS).include? user_input

      (HELP_COMMANDS + COMPLEX_COMMANDS).map do |candidate|
        send("try_#{candidate.downcase}_command", user_input)
      end.compact&.first
    end

    def self.valid?(user_input)
      validate(user_input)
    end

    def self.inspect
      VALID_COMMANDS.sort.join(",")
    end

    def self.try_help_command(user_input)
      pattern = /^(HELP)$/
      matches = user_input.match(pattern)&.captures

      return unless matches

      Command.new(matches[0])
    end

    def self.try_place_command(user_input)
      pattern = /^(PLACE) (\d+),(\d+),(NORTH|EAST|WEST|SOUTH)$/
      matches = user_input.match(pattern)&.captures

      return unless matches

      name, x, y, face = matches
      Command.new(name, x: x, y: y, face: face)
    end
  end
end
