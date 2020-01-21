# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'onlyoffice_documentserver_conversion_helper/version'
Gem::Specification.new do |s|
  s.name = 'onlyoffice_documentserver_conversion_helper'
  s.version = OnlyofficeDocumentserverConversionHelper::Version::STRING
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.1'
  s.authors = ['Pavel Lobashov', 'Dmitry Rotaty']
  s.summary = 'onlyoffice_documentserver_conversion_helper Gem'
  s.description = 'Helper method for using ONLYOFFICE DocumentServer conversion api'
  s.email = ['shockwavenn@gmail.com', 'flaminestone@gmail.com']
  s.files = `git ls-files lib LICENSE.txt README.md`.split($RS)
  s.homepage = 'http://rubygems.org/gems/onlyoffice_documentserver_conversion_helper'
  s.add_runtime_dependency('jwt', '~> 2')
  s.license = 'AGPL-3.0'
end
