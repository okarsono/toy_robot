# frozen_string_literal: true

module ToyRobot
  class Command
    attr_reader :name, :options

    def initialize(name, **opts)
      @name = name
      @options = opts
    end

    def help?
      name == "HELP"
    end
  end
end
