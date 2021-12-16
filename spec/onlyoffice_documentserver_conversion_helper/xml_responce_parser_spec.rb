# frozen_string_literal: true

require 'spec_helper'

describe XmlResponceParser do
  let(:parser) do
    described_class.new(File.read('assets/responce/formatte_responce_example.xml'), 'docx')
  end

  it 'eq result_url for template' do
    expect(parser.result_url).to eq('http://localhost/filename=output.docx')
  end

  it 'eq result_url for unformatted template' do
    parser = described_class.new(File.read('assets/responce/unformatte_response_example.xml'), 'docx')
    expect(parser.result_url).to eq('http://localhost/filename=output.docx')
  end
end
