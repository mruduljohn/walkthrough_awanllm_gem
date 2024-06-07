

---

# 🌟 WalkthroughAwanllm

Welcome to **WalkthroughAwanllm**—the Ruby gem that seamlessly integrates with the AwanLLM API to document your project's development journey. This tool logs activities and generates comprehensive walkthroughs of your project's lifecycle. It lively tracks the git commit history and generates a walkthrough for the same. In order to efficiently use this gem ,install the gem at the beginning of your project development journey itself and make sure to make commits with legible and clear captions.

[![Gem Version](https://badge.fury.io/rb/walkthrough_awanllm.svg)](https://badge.fury.io/rb/walkthrough_awanllm)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Code of Conduct](https://img.shields.io/badge/Code%20of%20Conduct-Contributor%20Covenant-blue.svg)](https://github.com/mruduljohn/walkthrough_awanllm/blob/master/CODE_OF_CONDUCT.md)

> **Credits:** All thanks to the creators of the AwanLLM API for providing a free tier.  
> Contact us at [contact.awanllm@gmail.com](mailto:contact.awanllm@gmail.com) or visit [awanllm.com](https://www.awanllm.com/).

## 🚀 Installation

To add this gem to your application, include the following line in your `Gemfile`:

```ruby
gem 'walkthrough_awanllm'
```

Then, run:

```sh
$ bundle install
```

Alternatively, you can install it directly using:

```sh
$ gem install walkthrough_awanllm
```

## ⚙️ Setup

After installation, configure the gem by running the setup script. This script will prompt you to enter your AwanLLM API key and choose a model name.

```sh
$ ruby ./vendor/bundle/ruby/YOUR_VERSION/gems/walkthrough_awanllm-0.2.12/bin/setup_awanllm.rb
```

👉 **Get your API key** from [AwanLLM](https://www.awanllm.com/).

During setup, you can choose from the following models:

| Model Name                    | Version | Context Limit | SR         | PR          | Description                                     |
|-------------------------------|---------|---------------|------------|-------------|-------------------------------------------------|
| **Meta-Llama-3-8B-Instruct**  | 3.0     | 8192          | 40 t/s     | 150 t/s     | General use, verbose, less refusal              |
| **Awanllm-Llama-3-8B-Dolfin** | 1.0     | 8192          | 40 t/s     | 150 t/s     | Exact instruction following, less refusals, no warnings |
| **Awanllm-Llama-3-8B-Cumulus**| 1.0     | 8192          | 40 t/s     | 150 t/s     | Ideal for storywriting or RP, zero refusal, follows characters |
| **Mistral-7B-Instruct**       | 0.3     | 32768         | 60 t/s     | 500 t/s     | Fast response, high context limit, function calling |

## 📘 Usage

### Generate a Walkthrough

To create a detailed walkthrough of your project's activities, use the following commands in the Rails console:

```ruby
rails console
> awanllm = WalkthroughAwanllm::AwanLLM.new
> awanllm.generate_walkthrough
```

If the above doesn't work, you can alternatively run:

```ruby
$ rails awanllm:generate_walkthrough
```

This generates a `walkthrough.md` file in your project's root directory.

You may modify the 'prompt' variable inside ./vendor/bundle/ruby/YOUR_VERSION/gems/walkthrough_awanllm-0.2.12/lib/walkthrough_awanllm.rb to mathc your custom way of creating walkthrough.md file


## 🛠️ Development

To start developing, check out the repository and run:

```sh
$ bin/setup
```

For an interactive prompt to experiment with the gem:

```sh
$ bin/console
```

To install the gem onto your local machine:

```sh
$ bundle exec rake install
```

To release a new version, update the version number in `lib/walkthrough_awanllm/version.rb`, and then run:

```sh
$ bundle exec rake release
```

This will create a git tag, push commits and tags, and push the `.gem` file to [RubyGems.org](https://rubygems.org).

## 🤝 Contributing

We welcome bug reports and pull requests on [GitHub](https://github.com/mruduljohn/walkthrough_awanllm). This project fosters a safe and welcoming environment for collaboration. Please read and follow our [Code of Conduct](https://github.com/mruduljohn/walkthrough_awanllm/blob/master/CODE_OF_CONDUCT.md).

## 📜 License

**WalkthroughAwanllm** is open-source software licensed under the [MIT License](https://opensource.org/licenses/MIT).

---

We hope you find **WalkthroughAwanllm** useful! If you encounter any issues or have suggestions, don't hesitate to reach out. Happy coding! 🚀

---