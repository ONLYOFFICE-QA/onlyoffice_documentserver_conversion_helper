# frozen_string_literal: true

require 'spec_helper'

describe XmlResponceParser do
  let(:url) do
    described_class.new(File.read('assets/responce/local.xml'), 'docx')
  end

  it 'eq result_url for template' do
    expect(url.result_url).to eq('http://localhost/filename=output.docx')
  end
end
