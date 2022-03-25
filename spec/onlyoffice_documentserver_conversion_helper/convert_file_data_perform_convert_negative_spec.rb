# frozen_string_literal: true

require 'spec_helper'

describe OnlyofficeDocumentserverConversionHelper::ConvertFileData, '#perform_convert_negative' do
  let(:converter) do
    described_class.new('https://localhost')
  end

  it 'Convert test odt to unknown format' do
    expect { converter.perform_convert(url: 'https://example.com/fake.unknown') }
      .to raise_error(OnlyofficeDocumentserverConversionHelper::UnknownConvertFormatError,
                      /Unknown convert auto format: unknown/)
  end

  it 'Convert raise error if no url specified' do
    expect { converter.perform_convert }
      .to raise_error(StandardError,
                      /Parameter :url with link on file is necessary!!/)
  end
end
