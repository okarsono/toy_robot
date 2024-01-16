# frozen_string_literal: true

module ToyRobot
  class RobotService
    attr_reader :robot

    def initialize
      @robot = nil
    end

    def execute(command)
      return false if robot.nil? && !command.place?

      if command.place?
        initialize_robot(command.options)
      else
        robot.send(command.name.downcase, **command.options)
      end
    end

    def initialize_robot(options)
      required_options = %i[x y direction]
      x, y, direction = options.slice(*required_options).values
      @robot = Robot.new(x, y, direction, **options.except(*required_options))
      ToyRobot.logger.info "Robot initialized and placed on the board"
    end
  end
end
