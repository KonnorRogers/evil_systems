# Purpose

I write tests using Minitest and routinely reference [EvilMartians System
of a Test blog post](https://evilmartians.com/chronicles/system-of-a-test-setting-up-end-to-end-rails-testing)
for best practices for system tests. In this blog post,
they also have an opinionated way of setting up System Tests.

`EvilSystems` offers 3 distinct advantages over the setup provided by
EvilMartians System of a Test:

1.) The blog post was built with RSpec in mind, but we use Minitest
here!

2.) Constantly copying 5 files over into every new Rails app is annoying. Lets make that easier!

3.) File changes can end up out of sync, a gem makes sure updates can be
pushed to all users.

`EvilSystems` is a quick, easy, reusable way to apply the SoaT concepts and settings
to projects for system tests using Minitest.

Full API documentation can be found here:

https://rdoc.info/github/paramagicdev/evil_systems/main

## Installation

```ruby
# Gemfile
group :test do
  gem 'evil_systems', '~> 0.1.0'
end
```

Make sure the following 3 gems are in your `Gemfile` as well:

```ruby
# Gemfile
gem 'capybara'
gem 'cuprite' # Optional
gem 'selenium-webdriver' # Not required if using Cuprite and using Rails >= 6.1
```

And then execute:

```bash
bundle
```

## Setup

### Minitest

Navigate to `test/application_system_test_case.rb` in your Rails app.

Setup your file like so:

```ruby
# test/application_system_test_case.rb

require 'test_helper'

# 'capybara' and 'capybara/cuprite' need to be defined for EvilSystems to work properly.
require 'capybara'
require 'capybara/cuprite'

require 'evil_systems'

EvilSystems.initial_setup

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite

  include EvilSystems::Helpers
end
```

### RSpec

*Maybe in the future?*

## Whats included?

## Usage

`EvilSystems.initial_setup` takes two keyword arguments, `:task`, and
`silent`.

Both arguments have to do with precompiling assets.

`:silent` by default is set to `true` and will only tell you when assets
are compiling, and how long the compilation took.

`:task` defaults to `assets:precompile`, System of a test uses
`webpacker:compile`.

Example:

```rb
EvilSystems.initial_setup(task: "webpacker:compile", silent: false)
```

### Settings

- [x] - Automatically registers a `:cuprite` driver if `Capybara::Cuprite`
is defined.

- [x] - Automatically sets Capybara's default and javascript driver to
`:cuprite`

- [x] - Automatically sets `Capybara.app_host`

<details>
<summary>How `app_host` is set</summary>

`app_host` will first use `ENV["APP_HOST"]` then falls back to the systems
`hostname` if the `APP_HOST` ENV var is not defined.
If neither are defined, it will then default to `"0.0.0.0"`

</details>

- [x] - `Capybara.server_host = "0.0.0.0"` Make server listening on all hosts

- [x] - `Capybara.default_max_wait_time = 2` Dont spend forever waiting for matchers

- [x] - `Capybara.default_normalize_ws = true` normalizes whitespace in `has_text?` and similar matchers.

- [x] - Sets the `Capybara.save_path` Uses `ENV["CAPYBARA_ARTIFACTS"]` and falls back to `"./tmp/capybara"`

- [x] - Sets a `REMOTE_CHROME` instance if a `ENV["CHROME_URL"]` is found

- [x] - Prepends a `last_used_session` attribute accessor to Capybara.

### Helpers

`EvilSystems::Helpers`

Automatically includes `ActionView::RecordIdentifier` if Rails is
defined.

Also includes:

```rb
EvilSystems::CupriteHelpers
EvilSystems::SessionHelpers
```

#### Regular Helpers

```rb
# The full path to be prepended to a screen shot
absolute_image_path

# The relative path to be prepended to a screenshot message to make it clickable
image_path

# Make failure screenshots compatible with multi-session setup
take_screenshot

# Prepends a '#' to the +dom_id+ method provided by Rails
dom_id(*args)
```

#### SessionHelpers

```rb
# Small wrapper around Capybara.using_session thats easy to call from an instance
within_session(name_or_session, &block)
```

#### Cuprite Helpers

```rb
# pauses the page
pause

# Opens a Pry or IRB repl. Will use Pry if Pry is defined, fallsback
# to debugging with IRB
debug
```

### Env Variables

ENV variables used by this gem.

```rb
ENV["APP_HOST"] # used for Capybara.app_host
ENV["CAPYBARA_ARTIFACTS"] # used for Capybara.save_path
ENV["CHROME_URL"] # used for setting a remote chrome instance for Cuprite
ENV["PROCESS_TIMEOUT"] # How long to wait before killing the process, default is 5 seconds
ENV["CI"] # Whether or not to run Cuprite in headless mode, defaults to true.
```

## I don't want to use Cuprite.

Thats fine! I totally get it. Selenium is battle tested. Simply remove
the `require "capybara/cuprite"` line and `EvilSystems` will detect that
Cuprite is not defined and not setup a driver for you and not include
Cuprite helpers.

## Omissions and differences

- Will use `assets:precompile` instead of `webpacker:compile` before
  systems tests (configurable)

- Does not set the `Rails.application.default_url_options[:host]` due to
  parallelization issues found while testing the dummy app.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
