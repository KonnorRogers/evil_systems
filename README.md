# EvilSystemTests
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'evil_system_tests'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install evil_system_tests
```

## Setup

### Minitest

Navigate to `test/application_system_test_case.rb`

Setup your file like so:

```rb
# test/application_system_test_case.rb

require 'test_helper'

+ require 'evil_systems'

+ EvilSystems.initial_setup

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
-  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
+  driven_by :cuprite, using: :chrome, screen_size: [1400, 1400]

+ include EvilSystems::Helpers

+ def setup
+   EvilSystems.setup
+ end
end
```

### RSpec

*Coming Soon*

## Whats included?

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
