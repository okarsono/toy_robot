# frozen_string_literal: true

require_relative("robotic")

module ToyRobot
  module Command
    class Right < Base
      include Robotic
    end
  end
end
