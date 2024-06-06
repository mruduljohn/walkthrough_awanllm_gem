Here's an updated README for your gem `walkthrough_awanllm`, including all necessary installation and usage instructions, as well as development and contributing guidelines. All credits for AwanLLM goes to the orginal creators of API for offering a free tier. 

### Email: contact.awanllm@gmail.com
### https://www.awanllm.com/
```markdown
# WalkthroughAwanllm

A Ruby gem to generate a project development walkthrough with the AwanLLM API. This gem helps you log activities and generate detailed walkthroughs of your project's lifecycle.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'walkthrough_awanllm'
```

And then execute:

```sh
$ bundle install
```

Or install it yourself as:

```sh
$ gem install walkthrough_awanllm
```

## Setup

After installing the gem, you need to configure it by running the setup script. This will prompt you for your AwanLLM API key and the model name you wish to use.

```sh
$ ruby ./vendor/bundle/ruby/YOUR_VERSION/gems/walkthrough_awanllm-0.2.12/bin/setup_awanllm.rb
```

Get API key from https://www.awanllm.com/

## Usage


### Generating a Walkthrough

To generate a detailed walkthrough of your project's activities:

```ruby
rails console
> awanllm = WalkthroughAwanllm::AwanLLM.new
> awanllm.generate_walkthrough
```
(IF ABOVE IS NOT WORKING) by running :
```ruby
rails awanllm:generate_walkthrough
```
This will read the activity log and generate a `walkthrough.md` file in the project's root directory.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run:

```sh
$ bundle exec rake install
```

To release a new version, update the version number in `version.rb`, and then run:

```sh
$ bundle exec rake release
```

This will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mruduljohn/walkthrough_awanllm. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/mruduljohn/walkthrough_awanllm/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the WalkthroughAwanllm project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mruduljohn/walkthrough_awanllm/blob/master/CODE_OF_CONDUCT.md).
```
