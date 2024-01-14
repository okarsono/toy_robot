# frozen_string_literal: true

require_relative "lib/toy_robot/version"

Gem::Specification.new do |spec|
  spec.name = "toy_robot"
  spec.version = ToyRobot::VERSION
  spec.authors = ["Octa Karsono"]
  spec.email = ["ocpuso@gmail.com"]

  spec.summary = "A simple gem that moves a virtual robot"
  spec.description = "This is my solution to the challenge as set out in the SPECIFICATION.md"
  spec.homepage = "https://github.com/okarsono/toy_robot"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/okarsono/toy_robot/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w(bin/ test/ spec/ features/ .git .github appveyor Gemfile))
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "highline", "~> 3.0"
  spec.add_dependency "i18n", "~> 1.14"
  spec.add_dependency "thor", "~> 1.3"

  spec.add_development_dependency "pry", "~> 0.14"
  spec.add_development_dependency "pry-byebug", "~> 3.10"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.21"
end
