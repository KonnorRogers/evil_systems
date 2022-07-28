## 1.1.0

- Feature: add `driver_options` to `initial_setup`

## 1.0.0

- 🚨 BREAKING CHANGE - Renamed `:cuprite` driver to
`:evil_cuprite` to avoid naming collision in Rails 7.
<https://github.com/ParamagicDev/evil_systems/pull/7>

- Added `wait_for_network_idle!`
- Added `:skip_task` to avoid rake tasks all together.
<https://github.com/evil_systems/pull/8>

- Updated test suite to Rails 7

## 0.2.0

- Disable animations by default @julianrubisch <https://github.com/ParamagicDev/evil_systems/commit/cf72d1189c8bd8b72f130909f209f543a52aaf50>

## 0.1.3

- Add Slowmo option

## 0.1.1

- Fix readme issue
- Remove mark_all_banners_as_read
- Remove selenium-webdriver

## 0.1.0

- Allow the Cuprite driver to be configured with ENV variables for headless mode and process_timeouts.
- Increase process_timeout default to 5
- Add GH actions testing with a remote chrome instance
- Minor API cleanup

## 0.0.3

Initial release!
