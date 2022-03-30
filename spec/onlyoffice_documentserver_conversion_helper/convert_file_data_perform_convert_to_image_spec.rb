# frozen_string_literal: true

require 'spec_helper'

describe OnlyofficeDocumentserverConversionHelper::ConvertFileData, '#perform_convert_to_image' do
  let(:converter) do
    described_class.new('http://localhost')
  end

  it 'Convert file to thumbnail only first page will result not empty url' do
    expect(converter.perform_convert(url: ODP_FILE,
                                     thumbnail: { first: true },
                                     outputtype: 'png')[:url])
      .not_to be_empty
  end

  it 'Convert file to thumbnail will result not empty url' do
    expect(converter.perform_convert(url: ODP_FILE,
                                     thumbnail: { first: false },
                                     outputtype: 'png')[:url])
      .not_to be_empty
  end

  it 'Convert file to thumbnail without `first` key will result not empty url' do
    expect(converter.perform_convert(url: ODP_FILE,
                                     thumbnail: {},
                                     outputtype: 'png')[:url])
      .not_to be_empty
  end
end
