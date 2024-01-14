# ToyRobot

This project is created to showcase my proposed technical solution to the fun problem described in [[SPECIFICATION.md]].

It contains all the elements that I would use to make this production-quality.

It also contains some of the technical design/concepts:
* object-oriented programming
* code separation
* CI/CD
* automated tests

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add toy_robot

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install toy_robot

## Usage
    $ toy_robot play

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Dev Notes

### Adding/implementing a new command for robot

Below are steps to implement a new command for the robot:

1. Add the command to `lib/toy_robot/command.rb`, in either `SIMPLE_COMMANDS` or `COMPLEX_COMMANDS` (if the new command accepts argument(s)).
2. If the new command accepts argument(s), then please define `try_<command_name>_command` class method in `lib/toy_robot/command_validator.rb`. This method takes in user input as string format and should try to convert it to the actual command object.
3. Implement method of the same name as the command to `lib/toy_robot/robot.rb`
4. Add help/description for the new command in `config/locales/en.yml`
5. Write unit testing in `spec/toy_robot/robot_spec.rb`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/okarsono/toy_robot.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
