# frozen_string_literal: true

require_relative "toy_robot/cli"
require_relative "toy_robot/command"
require_relative "toy_robot/command_validator"
require_relative "toy_robot/game_service"
require_relative "toy_robot/robot"
require_relative "toy_robot/version"

module ToyRobot
  def self.logger
    @logger ||= defined?(Rails) ? Rails.logger : Logger.new($stdout)
  end

  def self.logger=(logger)
    @logger = logger
  end
end
