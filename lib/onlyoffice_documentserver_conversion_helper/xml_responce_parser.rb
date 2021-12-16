# frozen_string_literal: true

# Class for parse Xml responce
class XmlResponceParser
  def initialize(string_with_xml, file_format)
    @string_with_xml = string_with_xml
    @file_format = file_format
  end

  # Method parses server response
  # returning url with unescape HTML
  # @return [String] URL
  def result_url
    res_result = /(http|https).*(#{@file_format})/.match(@string_with_xml)
    CGI.unescapeHTML(res_result.to_s)
  end
end
