# frozen_string_literal: true

require 'spec_helper'

describe OnlyofficeDocumentserverConversionHelper::ConvertFileData do
  let(:converter) do
    described_class.new('http://localhost')
  end

  describe 'Convert test odt file to pdf' do
    let(:target) { converter.perform_convert(url: ODT_FILE) }

    it_behaves_like 'Correct Request'
  end

  describe 'Convert test ods file to pdf' do
    let(:target) { converter.perform_convert(url: ODS_FILE) }

    it_behaves_like 'Correct Request'
  end

  describe 'Convert test odp file to pdf' do
    let(:target) { converter.perform_convert(url: ODP_FILE) }

    it_behaves_like 'Correct Request'
  end
end
