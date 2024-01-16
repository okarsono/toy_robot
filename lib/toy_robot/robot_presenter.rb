# frozen_string_literal: true

module ToyRobot
  class RobotPresenter
    FORMAT_OPTIONS = %i[full short csv].freeze
    DEFAULT_FORMAT = FORMAT_OPTIONS.first

    def initialize(robot)
      @robot = robot
    end

    def report(chosen_format = DEFAULT_FORMAT)
      format = FORMAT_OPTIONS.include?(chosen_format&.to_sym) ? chosen_format.to_sym : DEFAULT_FORMAT

      I18n.t(".robot_reporter.#{format}", **@robot.report)
    end
  end
end
