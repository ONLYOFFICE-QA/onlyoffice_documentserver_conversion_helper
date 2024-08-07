# frozen_string_literal: true

require_relative 'lib/onlyoffice_documentserver_conversion_helper/name'
require_relative 'lib/onlyoffice_documentserver_conversion_helper/version'

Gem::Specification.new do |s|
  s.name = OnlyofficeDocumentserverConversionHelper::Name::STRING
  s.version = OnlyofficeDocumentserverConversionHelper::Version::STRING
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 3.0'
  s.authors = ['ONLYOFFICE', 'Pavel Lobashov', 'Dmitry Rotaty']
  s.email = %w[shockwavenn@gmail.com]
  s.summary = 'onlyoffice_documentserver_conversion_helper Gem'
  s.description = 'Helper method for using ' \
                  'ONLYOFFICE DocumentServer conversion api'
  s.homepage = "https://github.com/ONLYOFFICE-QA/#{s.name}"
  s.metadata = {
    'bug_tracker_uri' => "#{s.homepage}/issues",
    'changelog_uri' => "#{s.homepage}/blob/master/CHANGELOG.md",
    'documentation_uri' => "https://www.rubydoc.info/gems/#{s.name}",
    'homepage_uri' => s.homepage,
    'source_code_uri' => s.homepage,
    'rubygems_mfa_required' => 'true'
  }
  s.files = Dir['lib/**/*']
  s.license = 'AGPL-3.0'
  s.add_dependency('jwt', '~> 2')
end
