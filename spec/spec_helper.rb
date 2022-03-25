# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'onlyoffice_documentserver_conversion_helper'

shared_examples 'Correct Request' do
  it 'Result url is not emty' do
    expect(target[:url]).not_to be_nil
  end

  it 'Result url is an url' do
    expect(target[:url]).to match(URI::DEFAULT_PARSER.make_regexp)
  end
end

# @return [String] url of sample odt file
ODT_FILE = 'https://onlyoffice-documentserver-conversion-helper-rspec.s3.amazonaws.com/About-Svet.odt'
# @return [String] url of sample ods file
ODS_FILE = 'https://onlyoffice-documentserver-conversion-helper-rspec.s3.amazonaws.com/dun6a2.ods'
# @return [String] url of sample odp file
ODP_FILE = 'https://onlyoffice-documentserver-conversion-helper-rspec.s3.amazonaws.com/123.odp'
