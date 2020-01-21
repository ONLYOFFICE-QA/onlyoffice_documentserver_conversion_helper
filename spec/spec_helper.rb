# frozen_string_literal: true

if ENV['CI'] == 'true'
  require 'simplecov'
  SimpleCov.start
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require 'onlyoffice_documentserver_conversion_helper'

shared_examples 'Correct Request' do
  it 'Result url is not emty' do
    expect(target[:url]).not_to be_nil
  end

  it 'Result url is an url' do
    expect(target[:url]).to match(URI::DEFAULT_PARSER.make_regexp)
  end
end

ODT_FILE = 'https://s3.us-west-2.amazonaws.com/nct-data-share/odt/About-Svet.odt'
ODS_FILE = 'https://s3.us-west-2.amazonaws.com/nct-data-share/ods/dun6a2.ods'
ODP_FILE = 'https://s3.us-west-2.amazonaws.com/nct-data-share/odp/123.odp'
