# frozen_string_literal: true

module ToyRobot
  module Direction
    NORTH = "NORTH"
    EAST = "EAST"
    SOUTH = "SOUTH"
    WEST = "WEST"

    VALID_DIRECTIONS = [NORTH, EAST, SOUTH, WEST].freeze

    def parse(string)
      string if VALID_DIRECTIONS.include? string
    end
    module_function :parse
  end
end
