# frozen_string_literal: true

module ToyRobot
  module Command
    class Base
      attr_reader :name, :options

      def initialize(name, **opts)
        @name = name
        @options = opts
      end

      def help_instructions
        I18n.t(".command.#{ActiveSupport::Inflector.demodulize(self.class.name).downcase}")
      end
    end
  end
end
