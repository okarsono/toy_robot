# frozen_string_literal: true

module ToyRobot
  class Robot
    class InvalidRobotAttribute < StandardError; end

    attr_reader :x, :y, :direction, :x_max, :y_max

    def initialize(coord_x, coord_y, direction, **options)
      @x = coord_x
      @y = coord_y
      @direction = direction
      @x_max = (options[:board_x_length] || 5) - 1
      @y_max = (options[:board_y_length] || 5) - 1

      validate_attributes
    end

    def left
      @direction = ToyRobot::Direction::VALID_DIRECTIONS[previous_direction_index]
    end

    def right
      @direction = ToyRobot::Direction::VALID_DIRECTIONS[next_direction_index]
    end

    def move
      send("move_#{direction.downcase}")
    end

    def report
      puts "Robot is at [#{x},#{y}] facing #{direction}"
    end

    private

    def validate_attributes
      validate_coordinates
      validate_direction
    end

    def validate_coordinates
      validate_number("board x length", x_max + 1, min: 1)
      validate_number("board y length", y_max + 1, min: 1)
      validate_number("x", x, max: x_max)
      validate_number("y", y, max: y_max)
    end

    def validate_number(attribute_name, value, min: 0, max: nil)
      raise InvalidRobotAttribute, "#{attribute_name} must be a number" unless value.is_a? Integer
      raise InvalidRobotAttribute, "#{attribute_name} must be greater than or equal to #{min}" if value < min
      raise InvalidRobotAttribute, "#{attribute_name} must be less than or equal to #{max}" if !max.nil? && value > max
    end

    def validate_direction
      parsed_direction = ToyRobot::Direction.parse(direction)
      error_message = "direction must be one of #{ToyRobot::Direction::VALID_DIRECTIONS.join(",")}"
      raise InvalidRobotAttribute, error_message if parsed_direction.nil?
    end

    def current_direction_index
      ToyRobot::Direction::VALID_DIRECTIONS.find_index @direction
    end

    def next_direction_index
      (current_direction_index + 1) % size_of_directions
    end

    def previous_direction_index
      (current_direction_index - 1) % size_of_directions
    end

    def size_of_directions
      ToyRobot::Direction::VALID_DIRECTIONS.length
    end

    def move_on_axis(axis, forward: true)
      current_axis_coordinate = instance_variable_get("@#{axis}")
      current_axis_max_coordinate = instance_variable_get("@#{axis}_max")
      if forward
        instance_variable_set("@#{axis}", [current_axis_coordinate + 1, current_axis_max_coordinate].min)
      else
        instance_variable_set("@#{axis}", [current_axis_coordinate - 1, 0].max)
      end
    end

    def move_north
      move_on_axis(:y, forward: true)
    end

    def move_south
      move_on_axis(:y, forward: false)
    end

    def move_east
      move_on_axis(:x, forward: true)
    end

    def move_west
      move_on_axis(:x, forward: false)
    end
  end
end
