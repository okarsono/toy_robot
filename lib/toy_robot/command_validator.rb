# frozen_string_literal: true

require_relative("direction")

module ToyRobot
  class CommandValidator
    def self.validate(user_input)
      return Command.build(user_input) if (Command::SIMPLE_COMMANDS + Command::QUIT_COMMANDS).include? user_input

      (Command::HELP_COMMANDS + Command::COMPLEX_COMMANDS).map do |candidate|
        send("try_#{candidate.downcase}_command", user_input)
      end.compact&.first
    end

    def self.valid?(user_input)
      validate(user_input)
    end

    def self.inspect
      Command::VALID_COMMANDS.sort.join(",")
    end

    def self.try_help_command(user_input)
      pattern = /^(HELP)$/
      matches = user_input.match(pattern)&.captures

      return unless matches

      Command.build(matches[0])
    end

    def self.try_place_command(user_input)
      pattern = /^(PLACE) (\d+),(\d+),(NORTH|EAST|WEST|SOUTH)$/
      matches = user_input.match(pattern)&.captures

      return unless matches

      name, x, y, facing = matches
      Command.build(name, x: x.to_i, y: y.to_i, direction: ToyRobot::Direction.parse(facing))
    end
  end
end
