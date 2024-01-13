# frozen_string_literal: true

require "active_support"
require "i18n"

require_relative("command/base")
require_relative("command/help")
require_relative("command/left")
require_relative("command/move")
require_relative("command/place")
require_relative("command/report")
require_relative("command/right")
require_relative("command/quit")

module ToyRobot
  module Command
    class ImproperCommandError < StandardError; end

    def build(name, **opts)
      const_get(ActiveSupport::Inflector.titleize(name)).new(name, **opts)
    rescue NameError => e
      ToyRobot.logger.error "#{name} command is improperly configured: #{e.message}"
      raise ImproperCommandError, "#{name} command is improperly configured. Please use a different command."
    end
    module_function :build
  end
end
