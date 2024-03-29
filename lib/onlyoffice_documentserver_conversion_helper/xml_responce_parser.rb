# frozen_string_literal: true

module OnlyofficeDocumentserverConversionHelper
  # Class for parse Xml responce
  class XmlResponceParser
    def initialize(string_with_xml, file_format, result_in_zip: false)
      @string_with_xml = string_with_xml
      @file_format = file_format
      @result_in_zip = result_in_zip
    end

    # @return [String] output file format
    def file_format
      return 'zip' if @result_in_zip

      @file_format
    end

    # Method parses server response
    # returning url with unescape HTML
    # @return [String] URL
    def result_url
      res_result = /(http|https).*\.(#{file_format})/.match(@string_with_xml)
      CGI.unescapeHTML(res_result.to_s)
    end
  end
end
