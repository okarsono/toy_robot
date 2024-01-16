# frozen_string_literal: true

require_relative "lib/toy_robot/version"

Gem::Specification.new do |spec|
  spec.name = "toy_robot"
  spec.version = ToyRobot::VERSION
  spec.authors = ["Octa Karsono"]
  spec.email = ["ocpuso at gmail.com"]

  spec.summary = "A simple gem that moves a virtual robot"
  spec.description = "This is my solution to the challenge as set out in the SPECIFICATION.md"
  spec.homepage = "https://github.com/okarsono/toy_robot"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/okarsono/toy_robot/blob/main/CHANGELOG.md"

  spec.files = [
    "CHANGELOG.md",
    "Dockerfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "SPECIFICATION.md",
    "config/initializers/i18n.rb",
    "config/locales/en.yml",
    "exe/toy_robot",
    "lib/toy_robot.rb",
    "lib/toy_robot/cli.rb",
    "lib/toy_robot/command.rb",
    "lib/toy_robot/command_validator.rb",
    "lib/toy_robot/direction.rb",
    "lib/toy_robot/game_service.rb",
    "lib/toy_robot/robot.rb",
    "lib/toy_robot/robot_presenter.rb",
    "lib/toy_robot/robot_service.rb",
    "lib/toy_robot/version.rb",
    "robot.env",
    "sig/toy_robot.rbs",
    "toy_robot.gemspec"
  ]

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "highline", "~> 3.0"
  spec.add_dependency "i18n", "~> 1.14"
  spec.add_dependency "thor", "~> 1.3"

  spec.metadata["rubygems_mfa_required"] = "true"
end
