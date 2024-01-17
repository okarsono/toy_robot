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
      Command.all.sort.join(",")
    end

    def self.try_help_command(user_input)
      pattern = /^(HELP)( (#{(Command.all - Command::HELP_COMMANDS).join("|")})){0,1}$/
      matches = user_input.match(pattern)&.captures

      return unless matches

      options = { on: matches[2] }.compact
      Command.build(matches[0], **options)
    end

    def self.try_place_command(user_input)
      return unless user_input.match(/^PLACE/)

      pattern = /^(PLACE) (\d+),(\d+),(#{Direction::VALID_DIRECTIONS.join("|")})$/
      matches = user_input.match(pattern)&.captures

      raise Command::ImproperCommandError, "invalid PLACE command. Try HELP PLACE for help" unless matches

      name, x, y, facing = matches
      Command.build(name, x: x.to_i, y: y.to_i, direction: Direction.parse(facing))
    end
  end
end
