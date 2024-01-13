# frozen_string_literal: true

module ToyRobot
  class Robot
    class InvalidRobotAttribute < StandardError; end

    attr_reader :x, :y, :direction, :x_max, :y_max

    def initialize(coord_x, coord_y, direction, **options)
      @x = coord_x
      @y = coord_y
      @direction = direction
      @x_max = options[:x_max] || 5
      @y_max = options[:y_max] || 5

      validate_attributes
    end

    private

    def validate_attributes
      validate_coordinates
      validate_direction
    end

    def validate_coordinates
      raise InvalidRobotAttribute, "x must be a zero or positive number" if x.negative?
      raise InvalidRobotAttribute, "y must be a zero or positive number" if y.negative?
      raise InvalidRobotAttribute, "x coordinate is larger than board x-axis" if x >= x_max
      raise InvalidRobotAttribute, "y coordinate is larger than board y-axis" if y >= y_max
    end

    def validate_direction
      parsed_direction = ToyRobot::Direction.parse(direction)
      error_message = "direction must be one of #{ToyRobot::Direction::VALID_DIRECTIONS.join(",")}"
      raise InvalidRobotAttribute, error_message if parsed_direction.nil?
    end
  end
end
