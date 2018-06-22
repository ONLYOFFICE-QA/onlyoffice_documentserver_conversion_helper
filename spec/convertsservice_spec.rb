require 'spec_helper'

describe 'ConvertService' do
  let(:converter) { OnlyofficeDocumentserverConversionHelper::ConvertFileData.new('http://localhost') }

  it 'Convert test odt file to pdf' do
    result = converter.perform_convert(url: 'https://s3.us-west-2.amazonaws.com/nct-data-share/odt/About-Svet.odt')
    expect(result[:url]).not_to be_nil
    expect(result[:url]).to match(URI::DEFAULT_PARSER.make_regexp)
  end

  it 'Convert test ods file to pdf' do
    result = converter.perform_convert(url: 'https://s3.us-west-2.amazonaws.com/nct-data-share/ods/dun6a2.ods')
    expect(result[:url]).not_to be_nil
    expect(result[:url]).to match(URI::DEFAULT_PARSER.make_regexp)
  end

  it 'Convert test odp file to pdf' do
    result = converter.perform_convert(url: 'https://s3.us-west-2.amazonaws.com/nct-data-share/odp/123.odp')
    expect(result[:url]).not_to be_nil
    expect(result[:url]).to match(URI::DEFAULT_PARSER.make_regexp)
  end
end
