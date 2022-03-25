# Change log

## master (unreleased)

### Changes

* Remove unused `ConvertFileData#get_url_from_responce` method
* Remove `codecov` support and use `simplecov`
* Increase line and branch test coverage to 100%

## 0.4.0 (2022-03-09)

### New Features

* Add `yamllint` support in CI
* Add request.body encoding to jwt payload

### Changes

* Remove `codeclimate` config, since we don't use it any more
* Check `dependabot` at 8:00 Moscow time daily

### Fixes

* Fix `nodejs` version in CI

## 0.3.0 (2021-12-17)

### New Features

* Add `ruby-3.1` to CI

### Changes

* Use new uploader for `codecov` instead of deprecated one
* Require `mfa` for releasing gem
* Resolved the problem with the incorrect regexp script
* Remove `ruby-2.5` from CI since it's EOLed

## 0.2.0 (2021-01-27)

### New Features

* Use GitHub Actions instead of TravisCI
* Add `rake` development dependencies
* Add `markdownlint` check in CI
* Add support of `rubocop-performance` and `rubocop-rake`
* Add `dependabot` config
* Add `rubocop` check in CI
* Add CI check that 100% code is documented
* Add `rake` task to release gem

### Changes

* Require minimal ruby 2.5
* Cleanup `gemspec` file
* Store dependencies in `gemspec`
* Lock dependencies in `Gemfile.lock` stored in repo
* Add missing documentation
* Moved repo to `ONLYOFFICE-QA` org

### Fixes

* Fix incorrect link to test files

## 0.1.1 (2018-08-21)

### Changed

* Add async request sending

## 0.1.0

### New features

* Initial version
