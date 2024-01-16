# frozen_string_literal: true

require "logger"

require_relative "toy_robot/cli"
require_relative "toy_robot/command"
require_relative "toy_robot/command_validator"
require_relative "toy_robot/game_service"
require_relative "toy_robot/robot"
require_relative "toy_robot/robot_presenter"
require_relative "toy_robot/robot_service"
require_relative "toy_robot/version"

module ToyRobot
  def self.logger
    @logger ||= Logger.new($stdout).tap { |l| l.level = Logger::FATAL } # default to report only fatal error
  end

  def self.logger=(logger)
    @logger = logger
  end
end
