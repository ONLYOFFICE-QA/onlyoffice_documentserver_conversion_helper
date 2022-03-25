# frozen_string_literal: true

require 'spec_helper'

describe OnlyofficeDocumentserverConversionHelper::ConvertFileData, '#autocomplete_missing_params' do
  let(:converter) do
    converter = described_class.new('http://localhost')
    converter.input_filetype = 'odt'
    converter.file_url = ODT_FILE
    converter
  end

  it '#autocomplete_missing_params will not change existing key' do
    key = 'test'
    expect(converter.autocomplete_missing_params({ key: key })[:key]).to eq(key)
  end

  it '#autocomplete_missing_params will not change existing outputtype' do
    outputtype = 'pdf'
    expect(converter.autocomplete_missing_params({ outputtype: outputtype })[:outputtype]).to eq(outputtype)
  end

  it '#autocomplete_missing_params add filetype' do
    filetype = 'odt'
    expect(converter.autocomplete_missing_params(filetype: filetype)[:filetype]).to eq(filetype)
  end
end
