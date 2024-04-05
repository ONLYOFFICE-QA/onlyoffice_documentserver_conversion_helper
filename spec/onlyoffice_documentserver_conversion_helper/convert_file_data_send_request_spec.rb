# frozen_string_literal: true

require 'spec_helper'

describe OnlyofficeDocumentserverConversionHelper::ConvertFileData, '#send_request' do
  let(:converter) { described_class.new('http://localhost', timeout: 10) }

  it 'correctly handle 504 errors' do
    url504 = URI('https://httpstatuses.maor.io/504')
    http = Net::HTTP.new(url504.host, url504.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(url504)
    expect { converter.send_request(http, req) }.to raise_error(Timeout::Error, /execution expired/)
  end
end
