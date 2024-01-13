# frozen_string_literal: true

require_relative("../command_validator")

module ToyRobot
  module Command
    class Base
      ToyRobot::CommandValidator::VALID_COMMANDS.each do |command_name|
        define_method("#{command_name.downcase}?") do
          command_name == @name
        end
      end

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
